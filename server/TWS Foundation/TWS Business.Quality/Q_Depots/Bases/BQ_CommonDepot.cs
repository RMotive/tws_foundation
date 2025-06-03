using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Database.Quality.Disposing;
using CSM_Foundation.Database.Utilitites;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Quality.Q_Depots.Bases;

namespace CSM_Foundation.Database.Quality;

public abstract class BQ_CommonDepot<TCommon, TInternalEdge, TExternalEdge, TDepot, TDatabase>
    : BQ_CommonDataHandler
    where TCommon : CommonEntity<TInternalEdge, TExternalEdge>, new()
    where TInternalEdge : CommonEntityEdge<TCommon>
    where TExternalEdge : CommonEntityEdge<TCommon>
    where TDepot : BCommonDepot<TInternalEdge, TExternalEdge, TCommon>
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
    ///     Stores the most valid evaluable property from the current <see cref="TCommon"/>. used for ordering and filtering at View operations and evaluate their quality.
    /// </summary>
    protected readonly PropertyInfo Evaluable;

    /// <summary>
    ///     Generates a new behavior base for <see cref="BQ_Depot{TMigrationSet, TMigrationDepot, TMigrationDatabases}"/>.
    /// </summary>
    /// <param name="Factories">
    ///     Database factories for relations sampleEntity at external databases needed for <see cref="TCommon"/>.
    /// </param>
    /// <param name="Sign">
    ///     Database sign for identification purposes.
    /// </param>
    /// <param name="Database">
    ///     Main Entity <see cref="TCommon"/> database handler instance. If isn't given will use a default built instance.
    /// </param>
    public BQ_CommonDepot(string Sign, DatabaseFactory? Database = null, params DatabaseFactory[] Factories)
        : base(
            [
                ..Factories,
                () => Database?.Invoke() ?? DatabaseUtilities.Q_Construct<TDatabase>(Sign)
            ]
        ) {

        this.Database = (TDatabase)(Database?.Invoke() ?? DatabaseUtilities.Q_Construct<TDatabase>(Sign));
        Depot = (TDepot)Activator.CreateInstance(typeof(TDepot), this.Database, null)!;

        PropertyInfo[] entityProperties = typeof(TCommon).GetProperties();

        PropertyInfo? orderableTmp = null;
        foreach (PropertyInfo propertyInfo in entityProperties) {

            Type propertyType = propertyInfo.PropertyType;

            if (((propertyType != typeof(string)) && (propertyType != typeof(int))) || (propertyInfo.Name == nameof(IEntity.Discriminator))) {
                continue;
            }

            orderableTmp = propertyInfo;
            break;
        }

        Evaluable = orderableTmp ?? typeof(TCommon).GetProperty(nameof(IEntity.Id))!; // By default if the [Entity] doesn't have a valid evaluable property will use the Id. 
    }

    #region Abtraction

    /// <summary>
    ///     Creates a context [Entity] for testing data creation and assertion.
    /// </summary>
    /// <param name="Entropy">
    ///     Random 16 length value for unique properties.
    /// </param>
    /// <returns>
    ///     A correctly built <see cref="TCommon"/>.
    /// </returns>
    protected abstract TCommon EntityFactory(string Entropy);

    #endregion

    #region Private / Protected Functions

    /// <summary>
    ///     
    /// </summary>
    /// <param name="SampleEntities"></param>
    protected async Task CommitSampleEntities(ICollection<TCommon> SampleEntities) {
        await Database.SaveChangesAsync();
        foreach(TCommon common in SampleEntities) {
            TInternalEdge? internalRelation = common.Internal;
            TExternalEdge? externalRelation = common.External;

            common.Internal = null;
            common.External = null;
            
            Disposer.Push(common);

            if (internalRelation != null) {
                Disposer.Push(internalRelation);
                return;
            }

            Disposer.Push(externalRelation!);
           
        }
    }



    /// <summary>
    /// 
    /// </summary>
    /// <param name="expected"></param>
    /// <param name="actual"></param>
    protected void AssertEvaluable(TCommon expected, TCommon actual) {
        object? sampleEvaluableValue = Evaluable.GetValue(expected);
        object? overwrittenEvaluableValue = Evaluable.GetValue(actual);

        Assert.Equal(sampleEvaluableValue, overwrittenEvaluableValue);
    }

    /// <summary>
    ///     Looks into the database for a random <see cref="IEntity.Id"/> that hasn't been used yet.
    /// </summary>
    /// <param name="noStored">
    ///     Wheter the generator should verify the generated <see cref="IEntity.Id"/> isn't used
    ///     for a stored <typeparamref name="TCommon"/> yet.
    /// </param>
    /// <returns>
    ///     A valid random value for <see cref="IEntity.Id"/>
    /// </returns>
    protected async Task<long> GeneratePointer(bool noStored = false) {
        Random random = new();

        // Generate two 32-bit random integers
        int high = random.Next(int.MinValue, int.MaxValue);
        int low = random.Next(int.MinValue, int.MaxValue);

        // Combine them into a long value
        long randomLong = ((long)high << 32) | (uint)low;
        if (!noStored) {
            return randomLong;
        }

        bool iteratorLock;
        do {
            iteratorLock = await Database.Set<TCommon>().FindAsync(randomLong) is not null;
        } while (iteratorLock);

        return randomLong;
    }

    #endregion

    #region Sampling

    /// <summary>
    ///     Creates a new <see cref="TCommon"/> instance based on the <see cref="EntityFactory(string)"/> implementation.
    /// </summary>
    /// <returns> A new <see cref="TCommon"/> instance </returns>
    /// <remarks>
    ///     This <see cref="IEntity"/> instance is created but not stored in the database.
    /// </remarks>
    protected TCommon Sampling() {
        return RunEntityFactory(EntityFactory);
    }

    /// <summary>
    ///    Creates a new collection of <see cref="TCommon"/> instances based on the <see cref="EntityFactory(string)"/> implementation.
    /// </summary>
    /// <param name="Count">
    ///     Number of instances to create.
    /// </param>
    /// <returns>
    ///     A new <see cref="TCommon"/> instance collection.
    /// </returns>
    /// <remarks>
    ///     This <see cref="IEntity"/> instance collection is created but not stored in the database.
    /// </remarks>
    protected TCommon[] Sampling(int Count) {
        return [.. Enumerable.Range(0, Count).Select(_ => RunEntityFactory(EntityFactory))];
    }

    #endregion


    #region Q_Base View

    [Fact(DisplayName = "[View]: Simple view calculation")]
    public async Task ViewA() {
        const int viewPage = 1;
        await Store<TCommon, TInternalEdge, TExternalEdge>(30, EntityFactory);

        ViewOutput<TCommon> viewOutput = await Depot.View(
                new OperationInput<TCommon, ViewInput<TCommon>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 20,
                        Page = viewPage,
                    }
                }
            );

        Assert.Multiple(
            () => Assert.True(viewOutput.Pages > 1),
            () => Assert.True(viewOutput.Length > 0),
            () => Assert.Equal(viewPage, viewOutput.Page),
            () => Assert.Equal(viewOutput.Length, viewOutput.Entities.Length)
        );
    }

    [Fact(DisplayName = "[View]: Specific page selected")]
    public async Task ViewB() {
        const int viewPage = 2;
        await Store<TCommon, TInternalEdge, TExternalEdge>(30, EntityFactory);

        ViewOutput<TCommon> viewOutput = await Depot.View(
                new OperationInput<TCommon, ViewInput<TCommon>> {
                    Parameters = new ViewInput<TCommon> {
                        Retroactive = false,
                        Range = 20,
                        Page = viewPage,
                    }
                }
            );

        Assert.Multiple(
            () => Assert.True(viewOutput.Pages > 1),
            () => Assert.True(viewOutput.Length > 0),
            () => Assert.Equal(viewPage, viewOutput.Page),
            () => Assert.Equal(viewOutput.Length, viewOutput.Entities.Length)
        );
    }

    [Fact(DisplayName = $"[View]: Specific ordering by property")]
    public async Task ViewC() {

        ViewOutput<TCommon> orderedViewOutput = await Depot.View(
                        new OperationInput<TCommon, ViewInput<TCommon>> {
                            Parameters = new() {
                                Page = 1,
                                Range = 20,
                                Retroactive = false,
                                Orderings = [
                                    new ViewOrdering {
                                        Property = Evaluable.Name,
                                        Ordering = ViewOrderings.Descending,
                                    },
                                ],
                            },
                        }
                   );


        // --> Manual ordering undordered result for reference.
        TCommon[] orderedReferenceRecords = [.. orderedViewOutput.Entities];
        {
            Type setType = typeof(TCommon);
            ParameterExpression parameterExpression = Expression.Parameter(setType, $"X0");

            MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, Evaluable);
            UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
            Expression<Func<TCommon, object>> orderingExpression = Expression.Lambda<Func<TCommon, object>>(translationExpression, parameterExpression);

            IQueryable<TCommon> sorted = orderedReferenceRecords.AsQueryable();
            sorted = sorted.OrderByDescending(orderingExpression);
            orderedReferenceRecords = [.. sorted];
        }

        for (int i = 0; i < orderedReferenceRecords.Length; i++) {
            TCommon expected = orderedReferenceRecords[i];
            TCommon actual = orderedViewOutput.Entities[i];

            Assert.Equal(Evaluable.GetValue(expected), Evaluable.GetValue(actual));
        }
    }

    [Fact(DisplayName = "[View]: Using Date filter")]
    public async Task ViewD() {
        ViewOutput<TCommon> viewOutput = await Depot.View(
                new OperationInput<TCommon, ViewInput<TCommon>> {
                    Parameters = new() {
                        Page = 1,
                        Range = 20,
                        Retroactive = false,
                        Filters = [
                            new ViewFilterDate<TCommon> {
                                From = DateTime.UtcNow.Date,
                            },
                        ],
                    },
                }
            );


        Assert.All(
            viewOutput.Entities,
            (i) => {
                Assert.True(DateTime.Compare(i.Timestamp, DateTime.UtcNow.Date) > 0);
            }
        );
    }

    [SkippableFact(DisplayName = "[View]: Using Property filter (Contains)")]
    public async Task ViewE() {
        Skip.If(Evaluable.PropertyType != typeof(string), "This assertion is only available for entities that have an evaluable string property since CONTAINS method is currently only supported to filter string type properties.");

        TCommon sampleEntity = await Store<TCommon, TInternalEdge, TExternalEdge>(EntityFactory);
        object? sampleValue = Evaluable.GetValue(sampleEntity);
        ViewOutput<TCommon> qOut = await Depot.View(
                new OperationInput<TCommon, ViewInput<TCommon>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 20,
                        Page = 1,
                        Filters = [
                            new ViewFilterProperty<TCommon> {
                                Operator = ViewFilterOperators.CONTAINS,
                                Property = Evaluable.Name,
                                Value = sampleValue,
                            }
                        ],
                    }
                }
            );
        Assert.All(
            qOut.Entities,
            (i) => {
                object? value = Evaluable.GetValue(i);

                Assert.Equal(sampleValue, value);
            }
        );
    }

    [Fact(DisplayName = "[View]: Using filter Linear Evaluation (OR)")]
    public async Task ViewF() {
        TCommon[] entities = await Store<TCommon, TInternalEdge, TExternalEdge>(2, EntityFactory);

        List<object?> possibleValues = [];
        List<IViewFilter<TCommon>> filters = [];

        foreach (TCommon entity in entities) {
            object? sampleValue = Evaluable.GetValue(entity);
            filters.Add(
                    new ViewFilterProperty<TCommon> {
                        Operator = ViewFilterOperators.CONTAINS,
                        Property = Evaluable.Name,
                        Value = sampleValue,
                    }
                );
            possibleValues.Add(sampleValue);
        }
        ViewOutput<TCommon> viewOutput = await Depot.View(
                new OperationInput<TCommon, ViewInput<TCommon>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 20,
                        Page = 1,
                        Filters = [
                            new ViewFilterLogical<TCommon>{
                                Operator = ViewFilterLogicalOperators.OR,
                                Filters = [..filters],
                            },
                        ],
                    }
                }
            );
        Assert.All(
            viewOutput.Entities,
            (i) => {
                object? actualValue = Evaluable.GetValue(i);
                Assert.Contains(actualValue, possibleValues);
            }
        );
    }

    #endregion

    #region Q_Base Read

    [Fact(DisplayName = "[Read]: Reads an Entity by {Id}.")]
    public virtual async Task ReadA() {
        TCommon sample = await Store<TCommon, TInternalEdge, TExternalEdge>(EntityFactory);

        TCommon readEntity = await Depot.Read(sample.Id);
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
        TCommon[] samples = await Store<TCommon, TInternalEdge, TExternalEdge>(20, EntityFactory);
        long[] sampleIds = [.. samples.Select(i => i.Id)];

        BatchOperationOutput<TCommon> readEntities = await Depot.Read(sampleIds);
        Assert.Multiple(
                [
                    () => Assert.Empty(readEntities.Failures),
                    () => Assert.Equal(samples.Length, readEntities.SuccessesCount),
                    () => Assert.All(
                        readEntities.Successes,
                        (entity) => {
                            TCommon sample = samples.First(j => j.Id == entity.Id);

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
        TCommon[] samples = await Store<TCommon, TInternalEdge, TExternalEdge>(2, EntityFactory);
        TCommon samplePivot = samples[0];

        BatchOperationOutput<TCommon> readEntites = await Depot.Read(
                EntityBatchBehaviors.First,
                (entity) => entity.Id == samplePivot.Id || entity.Id == samples[1].Id
            );

        Assert.Multiple(
                [
                    () => Assert.Empty(readEntites.Failures),
                    () => Assert.Equal(1, readEntites.SuccessesCount),
                    () => {
                        TCommon readEntity = readEntites.Successes[0];

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
        TCommon[] samples = await Store<TCommon, TInternalEdge, TExternalEdge>(2, EntityFactory);
        TCommon samplePivot = samples[1];

        BatchOperationOutput<TCommon> readEntites = await Depot.Read(
                EntityBatchBehaviors.Last,
                (entity) => entity.Id == samplePivot.Id || entity.Id == samples[0].Id
            );

        Assert.Multiple(
                [
                    () => Assert.Empty(readEntites.Failures),
                    () => Assert.Equal(1, readEntites.SuccessesCount),
                    () => {
                        TCommon readEntity = readEntites.Successes[0];

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
        TCommon[] samples = await Store<TCommon, TInternalEdge, TExternalEdge>(2, EntityFactory);

        BatchOperationOutput<TCommon> readEntites = await Depot.Read(
                EntityBatchBehaviors.All,
                (entity) => entity.Id == samples[0].Id || entity.Id == samples[1].Id
            );

        Assert.Multiple(
                [
                    () => Assert.Empty(readEntites.Failures),
                    () => Assert.Equal(2, readEntites.SuccessesCount),
                    () => Assert.All(
                            samples,
                            (sample) => {
                                TCommon entity = readEntites.Successes.First(i => i.Id == sample.Id);

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

    #region Q_Base Create

    [Fact(DisplayName = "[Create]: Record created and unique store check")]
    public async Task CreateA() {
        TCommon sample = Sampling();

        TCommon storedEntity = await Depot.Create(sample);
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
        TCommon[] samples = Sampling(3);

        BatchOperationOutput<TCommon> qOut = await Depot.Create(samples);
        await CommitSampleEntities(samples);

        Assert.Multiple(
            [
                () => Assert.Equal(qOut.OperationsCount, samples.Length),
                () => Assert.True(qOut.SuccessesCount.Equals(samples.Length), qOut.FailuresCount > 0 ? qOut.Failures[0].Message : ""),
                () => Assert.All(qOut.Successes, i => { Assert.True(i.Id > 0); })
            ]
        );
    }

    #endregion


    #region Q_Base Update

    [Fact(DisplayName = $"[Update Entity]: Created when Create parameter enabled")]
    public virtual async Task UpdateA() {
        TCommon sample = RunEntityFactory(EntityFactory);

        UpdateOutput<TCommon> updateOutput = await Depot.Update(
                new OperationInput<TCommon, UpdateInput<TCommon>> {
                    Parameters = new UpdateInput<TCommon> {
                        Entity = sample,
                        Create = true,
                    },
                }
            );
        await CommitSampleEntities([updateOutput.Updated]);

        Assert.Multiple(
                [
                    () => Assert.Null(updateOutput.Original),
                    () => {
                        TCommon overwritten = updateOutput.Updated;

                        Assert.True(overwritten.Id > 0);
                        AssertEvaluable(sample, overwritten);
                    },
                ]
            );
    }

    [Fact(DisplayName = $"[Update Entity]: Throws CreateDisabled exception situation.")]
    public virtual async Task UpdateB() {
        TCommon sample = RunEntityFactory(EntityFactory);

        XDepot<TCommon> depotException = await Assert.ThrowsAsync<XDepot<TCommon>>(
                async () => {
                    UpdateOutput<TCommon> updateOutput = await Depot.Update(
                new OperationInput<TCommon, UpdateInput<TCommon>> {
                    Parameters = new UpdateInput<TCommon> {
                        Entity = sample,
                    },
                }
                    );
                }
            );

        Assert.Equal(XDepotSituations.CreateDisabled, depotException.Situation);
    }

    [Fact(DisplayName = $"[Update Entity]: Throws Unfound exception situation")]
    public virtual async Task UpdateC() {
        TCommon sample = RunEntityFactory(EntityFactory);
        sample.Id = await GeneratePointer();

        XDepot<TCommon> depotException = await Assert.ThrowsAsync<XDepot<TCommon>>(
                async () => {
                    UpdateOutput<TCommon> updateOutput = await Depot.Update(
                        new OperationInput<TCommon, UpdateInput<TCommon>> {
                            Parameters = new UpdateInput<TCommon> {
                                Entity = sample,
                            },
                        }
                    );
                }
            );
        Assert.Equal(XDepotSituations.Unfound, depotException.Situation);
    }

    [Fact(DisplayName = $"[Update Entity]: Entity gets updated correctly")]
    public virtual async Task UpdateD() {
        TCommon sample = await Store<TCommon, TInternalEdge, TExternalEdge>(EntityFactory);
        TCommon valueReference = RunEntityFactory(EntityFactory);

        object? sampleOriginalValue = Evaluable.GetValue(sample);

        Evaluable.SetValue(sample, Evaluable.GetValue(valueReference));

        UpdateOutput<TCommon> updateOutput = await Depot.Update(
                new OperationInput<TCommon, UpdateInput<TCommon>> {
                    Parameters = new UpdateInput<TCommon> {
                        Entity = sample,
                    },
                }
            );

        Assert.Multiple(
                [
                    () => Assert.NotNull(updateOutput.Original),
                    () => {
                        TCommon overwritten = updateOutput.Updated;

                        Assert.NotEqual(updateOutput.Original, overwritten);

                        Evaluable.SetValue(sample, sampleOriginalValue);

                        Assert.Equal(sample, overwritten);
                    }
                ]
            );
    }

    #endregion


    #region Q_Base Delete

    [Fact(DisplayName = $"[Delete Entity]: Using Id throws Unfound situation exception")]
    public virtual async Task DeleteA() {
        long unexistPointer = await GeneratePointer(true);

        XDepot<TCommon> depotException = await Assert.ThrowsAsync<XDepot<TCommon>>(
                async () => {
                    await Depot.Delete(unexistPointer);
                }
            );

        Assert.Equal(XDepotSituations.Unfound, depotException.Situation);
    }

    [Fact(DisplayName = $"[Delete Entity]: Deletes correctly an Entity with a given Common Entity")]
    public virtual async Task DeleteB() {
        TCommon entity = await Store<TCommon, TInternalEdge, TExternalEdge>(EntityFactory);

        await Depot.DeleteCommon(entity);
        await CommitSampleEntities([]);

        TCommon? searchedEntity = Database.Set<TCommon>().Find(entity.Id);
        Assert.Null(searchedEntity);
    }

    [Fact(DisplayName = $"[Delete Batch]: Deletes correctly a collection of entities based on a filter")]
    public virtual async Task DeleteC() {
        TCommon entity = (await Store<TCommon, TInternalEdge, TExternalEdge>(10, EntityFactory))[0];

        BatchOperationOutput<TCommon> deleteOutput = await Depot.DeleteCommon(
                new OperationInput<TCommon, BatchOperationInput<TCommon>>() {
                    Parameters = new BatchOperationInput<TCommon> {
                        Filter = (entityB) => entityB.Id == entity.Id,
                    }
                }
            );
        await CommitSampleEntities([]);

        Assert.Multiple(
                [
                    () => Assert.False(deleteOutput.Failed),
                    () => Assert.Empty(deleteOutput.Failures),
                    () => Assert.NotEmpty(deleteOutput.Successes),
                    () => {
                        TCommon deletedEntity = deleteOutput.Successes[0];

                        Assert.Equal(entity.Id, deletedEntity.Id);
                    },
                    () => {
                        Assert.Null(
                                Database.Set<TCommon>().Find(entity.Id)
                            );
                    }
                ]
            );
    }

    #endregion

}