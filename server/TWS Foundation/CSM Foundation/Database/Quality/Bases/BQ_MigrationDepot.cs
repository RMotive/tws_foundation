
using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Enumerators;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Database.Quality.Interfaces;

using Microsoft.EntityFrameworkCore;

using Xunit;

namespace CSM_Foundation.Database.Quality.Bases;

public abstract class BQ_MigrationDepot<TSet, TDepot, TDatabase>
    : IQ_MigrationDepot
    where TSet : class, IDatabasesSet, new()
    where TDepot : IMigrationDepot<TSet>, new()
    where TDatabase : BDatabaseSQLS<TDatabase>, new() {
    private readonly string Ordering;


    protected TDepot Depot { 
        get {
            return new TDepot();
        }
    }

    private static TDatabase Database { 
        get {
            return new TDatabase();
        }    
    }


    /// <summary>
    ///     Generates a new behavior base for <see cref="BQ_MigrationDepot{TMigrationSet, TMigrationDepot, TMigrationDatabases}"/>.
    /// </summary>
    /// <param name="Ordering">
    ///     Property name to perform <see cref="View"/> qualifications with ordering based on a property.
    /// </param>
    public BQ_MigrationDepot(string Ordering) {
        this.Ordering = Ordering;
    }

    protected void Restore(IDatabasesSet Set) {
        Database.Remove(Set);
        Database.SaveChanges();
    }
    protected void Restore(IDatabasesSet[] Sets) {
        Database.RemoveRange(Sets);
        Database.SaveChanges();
    }
    /// <summary>
    ///     
    /// </summary>
    /// <returns></returns>
    protected abstract TSet MockFactory();

    #region Q_Base

    [Fact]
    public async Task View() {
        TDatabase Database = BQ_MigrationDepot<TSet, TDepot, TDatabase>.Database;
        DbSet<TSet> Set = Database.Set<TSet>();

        #region Preparation (First-Fact) 
        TSet[] firstFactMocks = [];
        SetViewOptions firstFactOptions;
        {
            try {
                firstFactOptions = new() {
                    Retroactive = false,
                    Range = 20,
                    Page = 1,
                };
                int stored = Set.Count();
                if (stored < 21) {
                    int left = 21 - stored;
                    for (int i = 0; i < left; i++) {
                        TSet mock = MockFactory();
                        mock.Timestamp = DateTime.UtcNow;
                        firstFactMocks = [.. firstFactMocks, mock];
                    }

                    await Set.AddRangeAsync(firstFactMocks);
                    await Database.SaveChangesAsync();
                }
            } catch { Restore(firstFactMocks); throw; }
        }
        #endregion
        #region Preparation (Second-Fact)
        SetViewOptions secondFactOptions;
        {
            secondFactOptions = new() {
                Page = 2,
                Range = 20,
                Retroactive = false,
            };
        }
        #endregion
        #region Preparation (Third-Fact)
        SetViewOptions thirdFactOptions;
        {
            thirdFactOptions = new() {
                Page = 1,
                Range = 20,
                Retroactive = false,
                Orderings = [
                    new SetViewOrderOptions {
                        Property = Ordering,
                        Behavior = MIgrationViewOrderBehaviors.Descending,
                    },
                ],
            };
        }
        #endregion

        SetViewOut<TSet> firstFact = await Depot.View(firstFactOptions);
        SetViewOut<TSet> secondFact = await Depot.View(secondFactOptions);
        SetViewOut<TSet> thirdFact = await Depot.View(thirdFactOptions);

        try {
            #region First-Fact (View successfully page 1)
            {
                Assert.Multiple(
                    () => Assert.True(firstFact.Pages > 1),
                    () => Assert.True(firstFact.Records > 0),
                    () => Assert.Equal(firstFactOptions.Page, firstFact.Page),
                    () => Assert.Equal(firstFact.Records, firstFact.Sets.Length)
                );
            }
            #endregion
            #region Second-Fact (View successfully page 2)
            {
                Assert.Multiple(
                    () => Assert.True(secondFact.Pages > 1),
                    () => Assert.True(secondFact.Records > 0),
                    () => Assert.Equal(secondFactOptions.Page, secondFact.Page),
                    () => Assert.Equal(secondFact.Records, secondFact.Sets.Length)
                );
            }
            #endregion
            #region Third-Fact (View successfuly orders by Name)
            {
                TSet[] factRecords = thirdFact.Sets;
                TSet[] sortedRecords = firstFact.Sets;

                // --> Sorting unsorted.
                {
                    Type setType = typeof(TSet);
                    ParameterExpression parameterExpression = Expression.Parameter(setType, $"X0");
                    PropertyInfo property = setType.GetProperty(Ordering)
                        ?? throw new Exception($"Unexisted property ({Ordering}) on ({setType})");
                    MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, property);
                    UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
                    Expression<Func<TSet, object>> orderingExpression = Expression.Lambda<Func<TSet, object>>(translationExpression, parameterExpression);
                    IQueryable<TSet> sorted = sortedRecords.AsQueryable();
                    sorted = sorted.OrderByDescending(orderingExpression);
                    sortedRecords = [..sorted];
                }

                for (int i = 0; i < sortedRecords.Length; i++) {
                    TSet expected = sortedRecords[i];
                    TSet actual = factRecords[i];

                    PropertyInfo property = typeof(TSet).GetProperty(Ordering)!;
                    Assert.Equal(property.GetValue(expected), property.GetValue(actual));
                }
            }
            #endregion
        } catch { throw; } finally {
            Restore(firstFactMocks);
        }
    }

    [Fact]
    public async Task Create() {
        #region First-Fact (Set successfuly saved and generated)
        {
            TSet mock = MockFactory();
            TSet fact = await Depot.Create(mock);
            Assert.Multiple([
                () => Assert.True(fact.Id > 0),
                async () => await Assert.ThrowsAnyAsync<Exception>(async () => await Depot.Create(mock)),
                () => {
                    Restore(mock);
                }
            ]);

        }
        #endregion

        #region Second-Fact (Sets successfuly saved and generated)
        {
            TSet[] mocks = [];
            for (int i = 0; i < 3; i++) {
                mocks = [.. mocks, MockFactory()];
            }

            DatabasesTransactionOut<TSet> fact = await Depot.Create(mocks);

            Assert.Multiple([
                () => Assert.Equal(fact.QTransactions, mocks.Length),
                () => Assert.True(fact.QSuccesses.Equals(mocks.Length), fact.QFailures > 0 ? fact.Failures[0].System : ""),
                () => Assert.All(fact.Successes, i => {
                    Assert.True(i.Id > 0);
                }),
                () => {
                    Restore(fact.Successes);
                }
            ]);
        }
        #endregion
    }

    #endregion
}
