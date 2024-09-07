using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Enumerators;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Options.Filters;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Database.Quality.Interfaces;
using CSM_Foundation.Database.Quality.Tools;

using Microsoft.EntityFrameworkCore;

using Xunit;

namespace CSM_Foundation.Database.Quality.Bases;

/// <summary>
/// 
/// </summary>
/// <typeparam name="TSet"></typeparam>
/// <typeparam name="TDepot"></typeparam>
/// <typeparam name="TDatabase"></typeparam>
public abstract class BQ_Depot<TSet, TDepot, TDatabase>
    : IQ_Depot, IDisposable
    where TSet : class, ISet, new()
    where TDepot : IDepot<TSet>, new()
    where TDatabase : BDatabaseSQLS<TDatabase>, new() {

    protected readonly QDisposer Disposer;

    private readonly string Ordering;

    /// <summary>
    /// 
    /// </summary>
    protected TDepot Depot => new();
    /// <summary>
    /// 
    /// </summary>
    private static TDatabase Database => new();

    private readonly TSet[] StoredMocks;


    /// <summary>
    ///     Generates a new behavior base for <see cref="BQ_Depot{TMigrationSet, TMigrationDepot, TMigrationDatabases}"/>.
    /// </summary>
    /// <param name="Ordering">
    ///     Property name to perform <see cref="View"/> qualifications with ordering.
    /// </param>
    public BQ_Depot(string Ordering) {
        this.Ordering = Ordering;

        Disposer = new QDisposer {
            Factory = () => Database,
        };
        StoredMocks = StoreMocks(30);
    }
    public void Dispose() {
        Disposer.Dispose();
        GC.SuppressFinalize(this);
    }

    /// <summary>
    ///     
    /// </summary>
    /// <returns></returns>
    protected abstract TSet MockFactory(string RandomSeed);

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    protected abstract (string Property, string? Value)? FactorizeProperty(TSet Mock);

    /// <summary>
    ///     
    /// </summary>
    /// <param name="Quantity"></param>
    /// <returns></returns>
    protected TSet[] StoreMocks(int Quantity) {
        TDatabase database = Database;

        TSet[] storedMocks = GenerateMocks(Quantity);


        database.Set<TSet>().AddRange(storedMocks);
        database.SaveChanges();
        Disposer.Push(storedMocks);
        return storedMocks;
    }

    protected TSet[] GenerateMocks(int Quantity) {
        TSet[] storedMocks = [];

        for (int i = 0; i < Quantity; i++) {
            string seed = RandomUtils.String(16);

            TSet mock = MockFactory(seed);
            mock.Timestamp = DateTime.UtcNow;

            storedMocks = [..storedMocks, mock];
        }

        return storedMocks;
    }

    #region Q_Base View

    [Fact(DisplayName = "[View]: No ordering, no filters")]
    public async Task ViewA() {
        TDatabase Database = BQ_Depot<TSet, TDepot, TDatabase>.Database;
        DbSet<TSet> Set = Database.Set<TSet>();

        SetViewOptions<TSet> qViewOptions = new() {
            Retroactive = false,
            Range = 20,
            Page = 1,
        };

        SetViewOut<TSet> qOut = await Depot.View(qViewOptions);

        Assert.Multiple(
            () => Assert.True(qOut.Pages > 1),
            () => Assert.True(qOut.Records > 0),
            () => Assert.Equal(qOut.Page, qOut.Page),
            () => Assert.Equal(qOut.Records, qOut.Sets.Length)
        );
    }

    [Fact(DisplayName = "[View]: Specific page selected")]
    public async Task ViewB() {

        SetViewOptions<TSet> qViewOptions;
        {
            qViewOptions = new() {
                Retroactive = false,
                Range = 20,
                Page = 2,
            };
        }

        SetViewOut<TSet> qOut = await Depot.View(qViewOptions);

        Assert.Multiple(
            () => Assert.True(qOut.Pages > 1),
            () => Assert.True(qOut.Records > 0),
            () => Assert.Equal(qViewOptions.Page, qOut.Page),
            () => Assert.Equal(qOut.Records, qOut.Sets.Length)
        );
    }

    [Fact(DisplayName = $"[View]: Specific ordering by property")]
    public async Task ViewC() {

        SetViewOptions<TSet> qUnorderedViewOptions = new() {
            Page = 1,
            Range = 20,
            Retroactive = false,
        };
        SetViewOptions<TSet> qOrderedViewOptions = new() {
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

        SetViewOut<TSet> qOrderedOut = await Depot.View(qOrderedViewOptions);
        SetViewOut<TSet> qUnorderedOut = await Depot.View(qUnorderedViewOptions);

        // --> Manual ordering undordered result for reference.
        TSet[] orderedReferenceRecords = qUnorderedOut.Sets;
        {
            Type setType = typeof(TSet);
            ParameterExpression parameterExpression = Expression.Parameter(setType, $"X0");
            PropertyInfo property = setType.GetProperty(Ordering)
                ?? throw new Exception($"Unexisted property ({Ordering}) on ({setType})");
            MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, property);
            UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
            Expression<Func<TSet, object>> orderingExpression = Expression.Lambda<Func<TSet, object>>(translationExpression, parameterExpression);

            IQueryable<TSet> sorted = orderedReferenceRecords.AsQueryable();
            sorted = sorted.OrderByDescending(orderingExpression);
            orderedReferenceRecords = [.. sorted];
        }

        for (int i = 0; i < orderedReferenceRecords.Length; i++) {
            TSet expected = orderedReferenceRecords[i];
            TSet actual = orderedReferenceRecords[i];

            PropertyInfo property = typeof(TSet).GetProperty(Ordering)!;
            Assert.Equal(property.GetValue(expected), property.GetValue(actual));
        }
    }

    [Fact(DisplayName = "[View]: Using Date filter")]
    public async Task ViewD() {
        SetViewOptions<TSet> qViewOptions = new() {
            Page = 1,
            Range = 20,
            Retroactive = false,
            Filters = [
                new SetViewDateFilter<TSet> {
                    From = DateTime.UtcNow.Date,
                },
            ],
        };


        SetViewOut<TSet> qOut = await Depot.View(qViewOptions);


        Assert.All(qOut.Sets, (i) => {
            Assert.True(DateTime.Compare(i.Timestamp, DateTime.UtcNow.Date) > 0);
        });
    }

    [Fact(DisplayName = "[View]: Using Property filter (Contains)")]
    public async Task ViewE() {
        TSet mock  = StoredMocks[5];
        (string Property, string? Value)? factorization = FactorizeProperty(mock);

        if(factorization is null) { 
            return;    
        }


        SetViewOptions<TSet> qViewOptions = new() {
            Retroactive = false,
            Range = 20,
            Page = 1,
            Filters = [
                new SetViewPropertyFilter<TSet> {
                    Evaluation = SetViewFilterEvaluations.CONTAINS,
                    Property = factorization.Value.Property,
                    Value = factorization.Value.Value,
                }    
            ],
        };


        SetViewOut<TSet> qOut = await Depot.View(qViewOptions);


        PropertyInfo? pInfo = typeof(TSet).GetProperty(factorization.Value.Property);
        Assert.NotNull(pInfo);
        Assert.All(qOut.Sets, i => {
            object? value = pInfo.GetValue(i);

            Assert.Equal(value, factorization.Value.Value);
        });
    }

    [Fact(DisplayName = "[View]: Using filter Linear Evaluation (OR)")]
    public async Task ViewF() {
        TSet[] mocks = [StoredMocks[0], StoredMocks[1]];

        ISetViewFilter<TSet>[] filters = [];
        string property = "";
        string?[] values = [];
        foreach(TSet mock in mocks) {
            (string Property, string? Value)? factorization = FactorizeProperty(mock);
            if(factorization is null || factorization.Value.Property is null)
                return;

            property = factorization.Value.Property;
            values = [..values, factorization.Value.Value];
            filters = [
                new SetViewPropertyFilter<TSet> {
                    Evaluation = SetViewFilterEvaluations.CONTAINS,
                    Property = factorization.Value.Property,
                    Value = factorization.Value.Value,
                },
            ];
        }
        
        SetViewOptions<TSet> qViewOptions = new() {
            Retroactive = false,
            Range = 20,
            Page = 1,
            Filters = [
                new SetViewFilterLinearEvaluation<TSet>{
                    Operator = SetViewFilterEvaluationOperators.OR,
                    Filters = filters,
                },
            ],
        };
        SetViewOut<TSet> qOut = await Depot.View(qViewOptions);

        PropertyInfo? propMirror = typeof(TSet).GetProperty(property);
        Assert.NotNull(propMirror);

        Assert.All(qOut.Sets, i => {
            object? value = propMirror.GetValue(i);

            foreach(string? refValue in values) {
                if(refValue == (string?)value) 
                    return;
            }
            Assert.True(false);
        });
    }

    #endregion

    #region Q_Base Create

    [Fact(DisplayName = "[Create]: Record created and unique store check")]
    public async Task CreateA() {
        TSet mock = GenerateMocks(1)[0];

        TSet storedMock = await Depot.Create(mock);
        Disposer.Push(storedMock);

        Assert.Multiple([
            () => Assert.True(storedMock.Id > 0),
            async () => {
                await Assert.ThrowsAnyAsync<Exception>(async () => {
                    await Depot.Create(mock);
                });
            },
        ]);
    }

    [Fact(DisplayName = "[Create]: Multiple records created")]
    public async Task CreateB() {
        TSet[] mocks = GenerateMocks(3);

        DatabasesTransactionOut<TSet> qOut = await Depot.Create(mocks);
        Disposer.Push(qOut.Successes);

        Assert.Multiple([
            () => Assert.Equal(qOut.QTransactions, mocks.Length),
            () => Assert.True(qOut.QSuccesses.Equals(mocks.Length), qOut.QFailures > 0 ? qOut.Failures[0].System : ""),
            () => Assert.All(qOut.Successes, i => {
                Assert.True(i.Id > 0);
            })
        ]);
    }

    #endregion
}