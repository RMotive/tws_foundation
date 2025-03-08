using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Filters;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Database.Quality.Disposing;

using Xunit;

namespace CSM_Foundation.Database.Quality;

/// <summary>
///     [Abstract] class for Quality Depots implementations. This are classes that tests the functionallity quality of a certain <see cref="BDepot{TDatabase, TEntity}"/>, providing
///     default built-in tests for all these implementations.
/// </summary>
/// <typeparam name="TEntity">
///     [Entity] the <see cref="TDepot"/> is based on.
/// </typeparam>
/// <typeparam name="TDepot">
///     [Depot] to be qualified.
/// </typeparam>
/// <typeparam name="TDatabase">
///     [Database] that stores the <see cref="TEntity"/> data.
/// </typeparam>
public abstract class BQ_Depot<TEntity, TDepot, TDatabase>
    : BQ_DataHandler
    where TEntity : class, IEntity, new()
    where TDepot : IDepot<TEntity>, new()
    where TDatabase : BDatabase_SQLServer<TDatabase>, new() {

    /// <summary>
    ///     Depot instance to operate tests.
    /// </summary>
    protected readonly TDepot Depot = new();

    /// <summary>
    ///     Stores the most valid orderable property from the current <see cref="TEntity"/>.
    /// </summary>
    protected readonly PropertyInfo Orderable; 

    /// <summary>
    ///     Generates a new behavior base for <see cref="BQ_Depot{TMigrationSet, TMigrationDepot, TMigrationDatabases}"/>.
    /// </summary>
    /// <param name="Factories">
    ///     Database factories for relations entities at external databases needed for <see cref="TEntity"/>.
    /// </param>
    /// <param name="Database">
    ///     Main Entity <see cref="TEntity"/> database handler instance. If isn't given will use a default built instance.
    /// </param>
    public BQ_Depot(DatabaseFactory? Database = null, params DatabaseFactory[] Factories)
        : base([.. Factories, () => Database?.Invoke() ?? new TDatabase()]) {

        PropertyInfo[] entityProperties = typeof(TEntity).GetProperties();

        foreach(PropertyInfo propertyInfo in entityProperties) {


        }
    }

    /// <summary>
    ///     Creates a context [Entity] for testing data creation and assertion.
    /// </summary>
    /// <param name="Entropy">
    ///     Random 16 length value for unique properties.
    /// </param>
    /// <returns>
    ///     A correctly built <see cref="TEntity"/>.
    /// </returns>
    protected abstract TEntity EntityFactory(string Entropy);

    #region Q_Base View

    [Fact(DisplayName = "[View]: No ordering, no filters")]
    public async Task ViewA() {
        Store(30, EntityFactory);

        SetViewOptions<TEntity> qViewOptions = new() {
            Retroactive = false,
            Range = 20,
            Page = 1,
        };

        SetViewOut<TEntity> qOut = await Depot.View(qViewOptions);

        Assert.Multiple(
            () => Assert.True(qOut.Pages > 1),
            () => Assert.True(qOut.Length > 0),
            () => Assert.Equal(qOut.Page, qOut.Page),
            () => Assert.Equal(qOut.Length, qOut.Records.Length)
        );
    }

    [Fact(DisplayName = "[View]: Specific page selected")]
    public async Task ViewB() {

        SetViewOptions<TEntity> qViewOptions;
        {
            qViewOptions = new() {
                Retroactive = false,
                Range = 20,
                Page = 2,
            };
        }

        SetViewOut<TEntity> qOut = await Depot.View(qViewOptions);

        Assert.Multiple(
            () => Assert.True(qOut.Pages > 1),
            () => Assert.True(qOut.Length > 0),
            () => Assert.Equal(qViewOptions.Page, qOut.Page),
            () => Assert.Equal(qOut.Length, qOut.Records.Length)
        );
    }

    [Fact(DisplayName = $"[View]: Specific ordering by property")]
    public async Task ViewC() {

        SetViewOptions<TEntity> qUnorderedViewOptions = new() {
            Page = 1,
            Range = 20,
            Retroactive = false,
        };
        SetViewOptions<TEntity> qOrderedViewOptions = new() {
            Page = 1,
            Range = 20,
            Retroactive = false,
            Orderings = [
                new SetViewOrderOptions {
                        Property = ,
                        Order = SetViewOrders.Descending,
                },
            ],
        };

        SetViewOut<TEntity> qOrderedOut = await Depot.View(qOrderedViewOptions);
        SetViewOut<TEntity> qUnorderedOut = await Depot.View(qUnorderedViewOptions);

        // --> Manual ordering undordered result for reference.
        TEntity[] orderedReferenceRecords = qUnorderedOut.Records;
        {
            Type setType = typeof(TEntity);
            ParameterExpression parameterExpression = Expression.Parameter(setType, $"X0");
            PropertyInfo property = setType.GetProperty(Ordering)
                ?? throw new Exception($"Unexisted property ({Ordering}) on ({setType})");
            MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, property);
            UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
            Expression<Func<TEntity, object>> orderingExpression = Expression.Lambda<Func<TEntity, object>>(translationExpression, parameterExpression);

            IQueryable<TEntity> sorted = orderedReferenceRecords.AsQueryable();
            sorted = sorted.OrderByDescending(orderingExpression);
            orderedReferenceRecords = [.. sorted];
        }

        for (int i = 0; i < orderedReferenceRecords.Length; i++) {
            TEntity expected = orderedReferenceRecords[i];
            TEntity actual = orderedReferenceRecords[i];

            PropertyInfo property = typeof(TEntity).GetProperty(Ordering)!;
            Assert.Equal(property.GetValue(expected), property.GetValue(actual));
        }
    }

    [Fact(DisplayName = "[View]: Using Date filter")]
    public async Task ViewD() {
        SetViewOptions<TEntity> qViewOptions = new() {
            Page = 1,
            Range = 20,
            Retroactive = false,
            Filters = [
                new SetViewDateFilter<TEntity> {
                    From = DateTime.UtcNow.Date,
                },
            ],
        };


        SetViewOut<TEntity> qOut = await Depot.View(qViewOptions);


        Assert.All(qOut.Records, (i) => {
            Assert.True(DateTime.Compare(i.Timestamp, DateTime.UtcNow.Date) > 0);
        });
    }

    [Fact(DisplayName = "[View]: Using Property filter (Contains)")]
    public async Task ViewE() {

        if (factorization is null) {
            return;
        }


        SetViewOptions<TEntity> qViewOptions = new() {
            Retroactive = false,
            Range = 20,
            Page = 1,
            Filters = [
                new SetViewPropertyFilter<TEntity> {
                    Evaluation = SetViewFilterEvaluations.CONTAINS,
                    Property = factorization.Value.Property,
                    Value = factorization.Value.Value,
                }
            ],
        };


        SetViewOut<TEntity> qOut = await Depot.View(qViewOptions);


        PropertyInfo? pInfo = typeof(TEntity).GetProperty(factorization.Value.Property);
        Assert.NotNull(pInfo);
        Assert.All(qOut.Records, i => {
            object? value = pInfo.GetValue(i);

            Assert.Equal(value, factorization.Value.Value);
        });
    }

    [Fact(DisplayName = "[View]: Using filter Linear Evaluation (OR)")]
    public async Task ViewF() {
        TEntity[] mocks = [StoredMocks[0], StoredMocks[1]];

        ISetViewFilter<TEntity>[] filters = [];
        string property = "";
        string?[] values = [];
        foreach (TEntity mock in mocks) {
            (string Property, string? Value)? factorization = FactorizeProperty(mock);
            if (factorization is null || factorization.Value.Property is null) {
                return;
            }

            property = factorization.Value.Property;
            values = [.. values, factorization.Value.Value];
            filters = [
                new SetViewPropertyFilter<TEntity> {
                    Evaluation = SetViewFilterEvaluations.CONTAINS,
                    Property = factorization.Value.Property,
                    Value = factorization.Value.Value,
                },
            ];
        }

        SetViewOptions<TEntity> qViewOptions = new() {
            Retroactive = false,
            Range = 20,
            Page = 1,
            Filters = [
                new SetViewFilterLinearEvaluation<TEntity>{
                    Operator = SetViewFilterEvaluationOperators.OR,
                    Filters = filters,
                },
            ],
        };
        SetViewOut<TEntity> qOut = await Depot.View(qViewOptions);

        PropertyInfo? propMirror = typeof(TEntity).GetProperty(property);
        Assert.NotNull(propMirror);

        Assert.All(qOut.Records, i => {
            object? value = propMirror.GetValue(i);

            foreach (string? refValue in values) {
                if (refValue == (string?)value) {
                    return;
                }
            }
            Assert.True(false);
        });
    }

    #endregion

    #region Q_Base Create

    [Fact(DisplayName = "[Create]: Record created and unique store check")]
    public async Task CreateA() {
        TEntity mock = Store(EntityFactory);

        TEntity storedMock = await Depot.Create(mock);
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
        TEntity[] mocks = Store(3, EntityFactory);

        SetBatchOut<TEntity> qOut = await Depot.Create(mocks);
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