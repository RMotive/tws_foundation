using System.Linq.Expressions;
using System.Reflection;
using System.Threading.Tasks;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Filters;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Out;
using CSM_Foundation.Database.Quality.Disposing;
using CSM_Foundation.Database.Utilitites;

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
    where TDepot : IDepot<TEntity>
    where TDatabase : BDatabase_SQLServer<TDatabase> {

    /// <summary>
    ///     Depot instance to operate tests.
    /// </summary>
    protected readonly TDepot Depot;

    /// <summary>
    ///     Database context the <see cref="Depot"/> is using.
    /// </summary>
    protected readonly TDatabase Database;

    /// <summary>
    ///     Stores the most valid evaluable property from the current <see cref="TEntity"/>. used for ordering and filtering at View operations and evaluate their quality.
    /// </summary>
    protected readonly PropertyInfo Evaluable;

    /// <summary>
    ///     Generates a new behavior base for <see cref="BQ_Depot{TMigrationSet, TMigrationDepot, TMigrationDatabases}"/>.
    /// </summary>
    /// <param name="Factories">
    ///     Database factories for relations sampleEntity at external databases needed for <see cref="TEntity"/>.
    /// </param>
    /// <param name="Sign">
    ///     Database sign for identification purposes.
    /// </param>
    /// <param name="Database">
    ///     Main Entity <see cref="TEntity"/> database handler instance. If isn't given will use a default built instance.
    /// </param>
    public BQ_Depot(string Sign, DatabaseFactory? Database = null, params DatabaseFactory[] Factories)
        : base(
            [
                ..Factories,
                () => Database?.Invoke() ?? DatabaseUtilities.Construct<TDatabase>(Sign)
            ]
        ) {

        this.Database = (TDatabase)(Database?.Invoke() ?? DatabaseUtilities.Construct<TDatabase>(Sign));
        Depot = (TDepot)Activator.CreateInstance(typeof(TDepot), this.Database, null)!;

        PropertyInfo[] entityProperties = typeof(TEntity).GetProperties();

        PropertyInfo? orderableTmp = null;
        foreach (PropertyInfo propertyInfo in entityProperties) {

            Type propertyType = propertyInfo.PropertyType;

            if (((propertyType != typeof(string)) && (propertyType != typeof(int))) || (propertyInfo.Name == nameof(IEntity.Discriminator))) {
                continue;
            }

            orderableTmp = propertyInfo;
        }

        Evaluable = orderableTmp ?? typeof(TEntity).GetProperty(nameof(IEntity.Id))!; // By default if the [Entity] doesn't have a valid evaluable property will use the Id. 
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

    /// <summary>
    ///     
    /// </summary>
    /// <param name="SampleEntities"></param>
    protected async Task CommitSampleEntities(ICollection<IEntity> SampleEntities) {
        await Database.SaveChangesAsync();
        Disposer.Push([.. SampleEntities]);
    }

    #region Sampling

    /// <summary>
    ///     Creates a new <see cref="TEntity"/> instance based on the <see cref="EntityFactory(string)"/> implementation.
    /// </summary>
    /// <returns> A new <see cref="TEntity"/> instance </returns>
    /// <remarks>
    ///     This <see cref="IEntity"/> instance is created but not stored in the database.
    /// </remarks>
    protected TEntity Sampling() {
        return RunEntityFactory(EntityFactory);
    }

    /// <summary>
    ///    Creates a new collection of <see cref="TEntity"/> instances based on the <see cref="EntityFactory(string)"/> implementation.
    /// </summary>
    /// <param name="Count">
    ///     Number of instances to create.
    /// </param>
    /// <returns>
    ///     A new <see cref="TEntity"/> instance collection.
    /// </returns>
    /// <remarks>
    ///     This <see cref="IEntity"/> instance collection is created but not stored in the database.
    /// </remarks>
    protected TEntity[] Sampling(int Count) {
        return [.. Enumerable.Range(0, Count).Select(_ => RunEntityFactory(EntityFactory))];
    }

    #endregion

    #region Q_Base Create

    [Fact(DisplayName = "[Create]: Record created and unique store check")]
    public async Task CreateA() {
        TEntity sample = Sampling();

        TEntity storedEntity = await Depot.Create(sample);
        await CommitSampleEntities([storedEntity]);

        Assert.Multiple(
            [
                () => Assert.True(storedEntity.Id > 0),
                async () => {
                    await Assert.ThrowsAnyAsync<Exception>(
                        async () => {
                            await Depot.Create(sample);
                            await CommitSampleEntities([sample]);
                        }
                    );
                },
            ]
        );
    }

    [Fact(DisplayName = "[Create]: Multiple records created")]
    public async Task CreateB() {
        TEntity[] samples = Sampling(3);

        EntityBatchOut<TEntity> qOut = await Depot.Create(samples);
        await CommitSampleEntities(samples);

        Assert.Multiple(
            [
                () => Assert.Equal(qOut.OperationsCount, samples.Length),
                () => Assert.True(qOut.QSuccesses.Equals(samples.Length), qOut.QFailures > 0 ? qOut.Failures[0].Message : ""),
                () => Assert.All(qOut.Successes, i => { Assert.True(i.Id > 0); })
            ]
        );
    }

    #endregion

    #region Q_Base Read

    [Fact(DisplayName = "[Read]: Reads an Entity by {Id}.")]
    public virtual async Task ReadA() {
        TEntity sample = Store(EntityFactory);

        TEntity readEntity = await Depot.Read(sample.Id);
        Assert.Multiple(
                [
                    () => Assert.Equal(sample.Id, readEntity.Id),
                    () => Assert.Equal(sample.Timestamp, readEntity.Timestamp),
                    () => {
                            object? sampleEvaluableValue = Evaluable.GetValue(sample);
                            object? readEvaluableValue = Evaluable.GetValue(readEntity);
                            Assert.Equal(sampleEvaluableValue, readEvaluableValue);
                        }
                ]
            );
    }

    [Fact(DisplayName = "[Read]: Reads a collection of entities by a collection of {Id}")]
    public virtual async Task ReadB() {
        TEntity[] samples = await Store(20, EntityFactory);
        long[] sampleIds = [..samples.Select(i => i.Id)];

        EntityBatchOut<TEntity> readEntities = await Depot.Read(sampleIds);
        Assert.Multiple(
                [
                    () => Assert.Empty(readEntities.Failures),
                    () => Assert.Equal(samples.Length, readEntities.QSuccesses),
                    () => Assert.All(
                        readEntities.Successes,
                        (entity) => {
                            TEntity sample = samples.First(j => j.Id == entity.Id);

                            Assert.Equal(sample.Id, entity.Id);
                            Assert.Equal(sample.Timestamp, entity.Timestamp);

                            object? evaluableSampleValue = Evaluable.GetValue(sample);
                            object? evaluableEntityValue = Evaluable.GetValue(entity);
                            Assert.Equal(evaluableSampleValue, evaluableEntityValue);
                        }
                    )
                ]
            );
    }

    [Fact(DisplayName = "[Read]: Reads for the first entity matching the filter")]
    public virtual async Task ReadC() {
        TEntity[] samples = await Store(2, EntityFactory);
        TEntity samplePivot = samples[0];

        EntityBatchOut<TEntity> readEntites = await Depot.Read(
                ReadBehaviors.First,
                (entity) => entity.Id == samplePivot.Id || entity.Id == samples[1].Id
            );

        Assert.Multiple(
                [
                    () => Assert.Empty(readEntites.Failures),
                    () => Assert.Equal(1, readEntites.QSuccesses),
                    () => {
                        TEntity readEntity = readEntites.Successes[0];

                        Assert.Equal(samplePivot.Id, readEntity.Id);
                        Assert.Equal(samplePivot.Timestamp, readEntity.Timestamp);

                        object? evaluableSampleValue = Evaluable.GetValue(samplePivot);
                        object? evaluableEntityValue = Evaluable.GetValue(readEntity);
                        Assert.Equal(evaluableSampleValue, evaluableEntityValue);
                    },
                ]
            );
    }

    [Fact(DisplayName = "[Read]: Reads for the last entity matching the filter")]
    public virtual async Task ReadD() {
        TEntity[] samples = await Store(2, EntityFactory);
        TEntity samplePivot = samples[1];

        EntityBatchOut<TEntity> readEntites = await Depot.Read(
                ReadBehaviors.Last,
                (entity) => entity.Id == samplePivot.Id || entity.Id == samples[0].Id
            );

        Assert.Multiple(
                [
                    () => Assert.Empty(readEntites.Failures),
                    () => Assert.Equal(1, readEntites.QSuccesses),
                    () => {
                        TEntity readEntity = readEntites.Successes[0];

                        Assert.Equal(samplePivot.Id, readEntity.Id);
                        Assert.Equal(samplePivot.Timestamp, readEntity.Timestamp);

                        object? evaluableSampleValue = Evaluable.GetValue(samplePivot);
                        object? evaluableEntityValue = Evaluable.GetValue(readEntity);
                        Assert.Equal(evaluableSampleValue, evaluableEntityValue);
                    },
                ]
            );
    }

    [Fact(DisplayName = "[Read]: Reads for all entities matching the filter")]
    public virtual async Task ReadE() {
        TEntity[] samples = await Store(2, EntityFactory);

        EntityBatchOut<TEntity> readEntites = await Depot.Read(
                ReadBehaviors.All,
                (entity) => entity.Id == samples[0].Id || entity.Id == samples[1].Id
            );

        Assert.Multiple(
                [
                    () => Assert.Empty(readEntites.Failures),
                    () => Assert.Equal(2, readEntites.QSuccesses),
                    () => Assert.All(
                            samples,
                            (sample) => {
                                TEntity entity = readEntites.Successes.First(i => i.Id == sample.Id);

                                Assert.Equal(sample.Id, entity.Id);
                                Assert.Equal(sample.Timestamp, entity.Timestamp);

                                object? evaluableSampleValue = Evaluable.GetValue(sample);
                                object? evaluableEntityValue = Evaluable.GetValue(entity);
                                Assert.Equal(evaluableSampleValue, evaluableEntityValue);
                            }
                        ),
                ]
            );
    }

    #endregion

    #region Q_Base Update



    #endregion

    #region Q_Base View

    [Fact(DisplayName = "[View]: Simple view calculation")]
    public async Task ViewA() {
        await Store(30, EntityFactory);

        SetViewOptions<TEntity> qViewOptions = new() {
            Retroactive = false,
            Range = 20,
            Page = 1,
        };

        SetViewOutput<TEntity> qOut = await Depot.View(qViewOptions);

        Assert.Multiple(
            () => Assert.True(qOut.Pages > 1),
            () => Assert.True(qOut.Length > 0),
            () => Assert.Equal(qOut.Page, qOut.Page),
            () => Assert.Equal(qOut.Length, qOut.Records.Length)
        );
    }

    [Fact(DisplayName = "[View]: Specific page selected")]
    public async Task ViewB() {
        await Store(30, EntityFactory);
        SetViewOptions<TEntity> qViewOptions;
        {
            qViewOptions = new() {
                Retroactive = false,
                Range = 20,
                Page = 2,
            };
        }

        SetViewOutput<TEntity> qOut = await Depot.View(qViewOptions);

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
                    Property = Evaluable.Name,
                    Order = SetViewOrders.Descending,
                },
            ],
        };

        SetViewOutput<TEntity> qOrderedOut = await Depot.View(qOrderedViewOptions);
        SetViewOutput<TEntity> qUnorderedOut = await Depot.View(qUnorderedViewOptions);

        // --> Manual ordering undordered result for reference.
        TEntity[] orderedReferenceRecords = qUnorderedOut.Records;
        {
            Type setType = typeof(TEntity);
            ParameterExpression parameterExpression = Expression.Parameter(setType, $"X0");

            MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, Evaluable);
            UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
            Expression<Func<TEntity, object>> orderingExpression = Expression.Lambda<Func<TEntity, object>>(translationExpression, parameterExpression);

            IQueryable<TEntity> sorted = orderedReferenceRecords.AsQueryable();
            sorted = sorted.OrderByDescending(orderingExpression);
            orderedReferenceRecords = [.. sorted];
        }

        for (int i = 0; i < orderedReferenceRecords.Length; i++) {
            TEntity expected = orderedReferenceRecords[i];
            TEntity actual = orderedReferenceRecords[i];

            Assert.Equal(Evaluable.GetValue(expected), Evaluable.GetValue(actual));
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


        SetViewOutput<TEntity> qOut = await Depot.View(qViewOptions);


        Assert.All(qOut.Records, (i) => {
            Assert.True(DateTime.Compare(i.Timestamp, DateTime.UtcNow.Date) > 0);
        });
    }

    [SkippableFact(DisplayName = "[View]: Using Property filter (Contains)")]
    public async Task ViewE() {
        Skip.If(Evaluable.PropertyType != typeof(string), "This assertion is only available for entities that have an evaluable string property since CONTAINS method is currently only supported to filter string type properties.");

        TEntity sampleEntity = Store(EntityFactory);
        object? sampleValue = Evaluable.GetValue(sampleEntity);

        SetViewOptions<TEntity> qViewOptions = new() {
            Retroactive = false,
            Range = 20,
            Page = 1,
            Filters = [
                new SetViewPropertyFilter<TEntity> {
                    Evaluation = SetViewFilterEvaluations.CONTAINS,
                    Property = Evaluable.Name,
                    Value = sampleValue,
                }
            ],
        };

        SetViewOutput<TEntity> qOut = await Depot.View(qViewOptions);
        Assert.All(
            qOut.Records,
            (i) => {
                object? value = Evaluable.GetValue(i);

                Assert.Equal(sampleValue, value);
            }
        );
    }

    [Fact(DisplayName = "[View]: Using filter Linear Evaluation (OR)")]
    public async Task ViewF() {
        TEntity[] entities = await Store(2, EntityFactory);


        List<object?> possibleValues = [];
        ISetViewFilter<TEntity>[] filters = [];
        foreach (TEntity entity in entities) {

            object? sampleValue = Evaluable.GetValue(entity);
            filters = [
                new SetViewPropertyFilter<TEntity> {
                    Evaluation = SetViewFilterEvaluations.CONTAINS,
                    Property = Evaluable.Name,
                    Value = sampleValue,
                },
            ];

            possibleValues.Add(sampleValue);
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

        SetViewOutput<TEntity> qOut = await Depot.View(qViewOptions);
        Assert.All(
            qOut.Records,
            (i) => {
                object? actualValue = Evaluable.GetValue(i);
                Assert.Contains(actualValue, possibleValues);
            }
        );
    }

    #endregion
}