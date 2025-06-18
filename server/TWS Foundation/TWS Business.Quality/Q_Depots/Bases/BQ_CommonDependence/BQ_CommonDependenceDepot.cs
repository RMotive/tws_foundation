using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_Read;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Database.Quality.Disposing;
using CSM_Foundation.Database.Utilitites;

using TWS_Business;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace CSM_Foundation.Database.Quality;

public abstract class BQ_CommonDependenceDepot<TDepot, TDatabase, TCommonDependence>
    : BQ_DataHandler
    where TCommonDependence : CommonDependeceEntity, new()
    where TDepot : BDepot<TDatabase, TCommonDependence>
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
    ///     Stores the most valid evaluable property from the current <see cref="TCommonDependence"/>. used for ordering and filtering at View operations and evaluate their quality.
    /// </summary>
    protected readonly PropertyInfo Evaluable;

    /// <summary>
    ///     Generates a new behavior base for <see cref="BQ_Depot{TMigrationSet, TMigrationDepot, TMigrationDatabases}"/>.
    /// </summary>
    /// <param name="Factories">
    ///     Database factories for relations sampleEntity at external databases needed for <see cref="TCommonDependence"/>.
    /// </param>
    /// <param name="Sign">
    ///     Database sign for identification purposes.
    /// </param>
    /// <param name="Database">
    ///     Main Entity <see cref="TCommonDependence"/> database handler instance. If isn't given will use a default built instance.
    /// </param>
    public BQ_CommonDependenceDepot(string Sign, DatabaseFactory? Database = null, params DatabaseFactory[] Factories)
        : base(
            [
                ..Factories,
                () => Database?.Invoke() ?? DatabaseUtilities.Q_Construct<TDatabase>(Sign)
            ]
        ) {

        this.Database = (TDatabase)(Database?.Invoke() ?? DatabaseUtilities.Q_Construct<TDatabase>(Sign));
        Depot = (TDepot)Activator.CreateInstance(typeof(TDepot), this.Database, null)!;

        PropertyInfo[] entityProperties = typeof(TCommonDependence).GetProperties();

        PropertyInfo? orderableTmp = null;
        foreach (PropertyInfo propertyInfo in entityProperties) {

            Type propertyType = propertyInfo.PropertyType;

            if (((propertyType != typeof(string)) && (propertyType != typeof(int))) || (propertyInfo.Name == nameof(IEntity.Discriminator))) {
                continue;
            }

            orderableTmp = propertyInfo;
            break;
        }

        Evaluable = orderableTmp ?? typeof(TCommonDependence).GetProperty(nameof(IEntity.Id))!; // By default if the [Entity] doesn't have a valid evaluable property will use the Id. 
    }

    #region Abtraction

    /// <summary>
    ///     Creates a context [Entity] for testing data creation and assertion.
    /// </summary>
    /// <param name="entropy">
    ///     Random 16 length value for unique properties.
    /// </param>
    /// <returns>
    ///     A correctly built <see cref="TCommonDependence"/>.
    /// </returns>
    protected abstract TCommonDependence EntityFactory(string entropy);

    /// <summary>
    ///     Creates a context [CommonEntityEdge] for testing data creation and assertion.
    /// </summary>
    /// <param name="entropy">
    ///     Random 16 length value for unique properties.
    /// </param>
    /// <returns>
    ///     A correctly built <see cref="TCommon"/>.
    /// </returns>
    protected abstract Truck_Common InternalTruckFactory(string entropy);

    protected abstract Truck_Common ExternalTruckFactory(string entropy);

    protected abstract Trailer_Common InternalTrailerFactory(string entropy);

    protected abstract Trailer_Common ExternalTrailerFactory(string entropy);

    protected abstract Driver_Common InternalDriverFactory(string entropy);

    protected abstract Driver_Common ExternalDriverFactory(string entropy);


    #endregion

    #region Private / Protected Functions
    protected TCommonDependence WrappedFactory(string entropy, bool isInternal) {
        TCommonDependence commonDependent = EntityFactory(entropy);

        if (isInternal) {
            commonDependent.Truck = InternalTruckFactory(entropy);
            commonDependent.Trailer = InternalTrailerFactory(entropy);
            commonDependent.Driver = InternalDriverFactory(entropy);
        } else {
            commonDependent.Truck = ExternalTruckFactory(entropy);
            commonDependent.Trailer = ExternalTrailerFactory(entropy);
            commonDependent.Driver = ExternalDriverFactory(entropy);
        }

        return commonDependent;
    }
    /// <summary>
    /// Commit the 
    /// </summary>
    /// <typeparam name="TCommon"></typeparam>
    /// <typeparam name="TInternal"></typeparam>
    /// <typeparam name="TExternal"></typeparam>
    /// <param name="common"></param>
    private void CommitDependences<TCommon, TInternal, TExternal>(TCommon common)
        where TCommon : CommonEntity<TInternal, TExternal>
        where TInternal : CommonEntityEdge<TCommon>
        where TExternal : CommonEntityEdge<TCommon> {

        TInternal? internalRelation = common.Internal;
        TExternal? externalRelation = common.External;

        common.Internal = null;
        common.External = null;

        Disposer.Push(common);

        if (internalRelation != null) {
            Disposer.Push(internalRelation);
            return;
        }

        Disposer.Push(externalRelation!);
    }

    /// <summary>
    ///     
    /// </summary>
    /// <param name="SampleEntities"></param>
    protected async Task CommitSampleEntities(ICollection<TCommonDependence> SampleEntities) {
        await Database.SaveChangesAsync();
        foreach (TCommonDependence commonDependent in SampleEntities.Reverse()) {
            Disposer.Push(commonDependent);
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="expected"></param>
    /// <param name="actual"></param>
    protected void AssertEvaluable(TCommonDependence expected, TCommonDependence actual) {
        object? sampleEvaluableValue = Evaluable.GetValue(expected);
        object? overwrittenEvaluableValue = Evaluable.GetValue(actual);

        Assert.Equal(sampleEvaluableValue, overwrittenEvaluableValue);
    }

    /// <summary>
    ///     Looks into the database for a random <see cref="IEntity.Id"/> that hasn't been used yet.
    /// </summary>
    /// <param name="noStored">
    ///     Wheter the generator should verify the generated <see cref="IEntity.Id"/> isn't used
    ///     for a stored <typeparamref name="TCommonDependence"/> yet.
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
            iteratorLock = await Database.Set<TCommonDependence>().FindAsync(randomLong) is not null;
        } while (iteratorLock);

        return randomLong;
    }

    #endregion

    #region Sampling

    /// <summary>
    ///     Creates a new <see cref="TCommonDependence"/> instance based on the <see cref="EntityFactory(string)"/> implementation.
    /// </summary>
    /// <returns> A new <see cref="TCommonDependence"/> instance </returns>
    /// <remarks>
    ///     This <see cref="IEntity"/> instance is created but not stored in the database.
    /// </remarks>
    protected TCommonDependence Sampling(bool DefaultEdge) {
        return RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge));
    }

    /// <summary>
    ///    Creates a new collection of <see cref="TCommonDependence"/> instances based on the <see cref="EntityFactory(string)"/> implementation.
    /// </summary>
    /// <param name="Count">
    ///     Number of instances to create.
    /// </param>
    /// <returns>
    ///     A new <see cref="TCommonDependence"/> instance collection.
    /// </returns>
    /// <remarks>
    ///     This <see cref="IEntity"/> instance collection is created but not stored in the database.
    /// </remarks>
    protected TCommonDependence[] Sampling(int Count, bool DefaultEdge) {
        return [.. Enumerable.Range(0, Count).Select(_ => RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge)))];
    }

    #endregion


    #region Q_Base View

    [Theory(DisplayName = "[View]: Simple view calculation"), CommonFactData]
    public async Task ViewA(bool DefaultEdge) {
        const int viewPage = 1;
        await Store(30, (entropy) => WrappedFactory(entropy, DefaultEdge));

        ViewOutput<TCommonDependence> viewOutput = await Depot.View(
                new QueryInput<TCommonDependence, ViewInput<TCommonDependence>> {
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

    [Theory(DisplayName = "[View]: Specific page selected")]
    [CommonFactData]
    public async Task ViewB(bool DefaultEdge) {
        const int viewPage = 2;
        await Store(30, (entropy) => WrappedFactory(entropy, DefaultEdge));

        ViewOutput<TCommonDependence> viewOutput = await Depot.View(
                new QueryInput<TCommonDependence, ViewInput<TCommonDependence>> {
                    Parameters = new ViewInput<TCommonDependence> {
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

        ViewOutput<TCommonDependence> orderedViewOutput = await Depot.View(
                        new QueryInput<TCommonDependence, ViewInput<TCommonDependence>> {
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
        TCommonDependence[] orderedReferenceRecords = [.. orderedViewOutput.Entities];
        {
            Type setType = typeof(TCommonDependence);
            ParameterExpression parameterExpression = Expression.Parameter(setType, $"X0");

            MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, Evaluable);
            UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
            Expression<Func<TCommonDependence, object>> orderingExpression = Expression.Lambda<Func<TCommonDependence, object>>(translationExpression, parameterExpression);

            IQueryable<TCommonDependence> sorted = orderedReferenceRecords.AsQueryable();
            sorted = sorted.OrderByDescending(orderingExpression);
            orderedReferenceRecords = [.. sorted];
        }

        for (int i = 0; i < orderedReferenceRecords.Length; i++) {
            TCommonDependence expected = orderedReferenceRecords[i];
            TCommonDependence actual = orderedViewOutput.Entities[i];

            Assert.Equal(Evaluable.GetValue(expected), Evaluable.GetValue(actual));
        }
    }

    [Fact(DisplayName = "[View]: Using Date filter")]
    public async Task ViewD() {
        ViewOutput<TCommonDependence> viewOutput = await Depot.View(
                new QueryInput<TCommonDependence, ViewInput<TCommonDependence>> {
                    Parameters = new() {
                        Page = 1,
                        Range = 20,
                        Retroactive = false,
                        Filters = [
                            new ViewFilterDate<TCommonDependence> {
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

    [Theory(DisplayName = "[View]: Using Property filter (Contains)")]
    [CommonFactData]
    public async Task ViewE(bool DefaultEdge) {
        Skip.If(Evaluable.PropertyType != typeof(string), "This assertion is only available for entities that have an evaluable string property since CONTAINS method is currently only supported to filter string type properties.");

        TCommonDependence sampleEntity = Store((entropy) => WrappedFactory(entropy, DefaultEdge));
        object? sampleValue = Evaluable.GetValue(sampleEntity);
        ViewOutput<TCommonDependence> qOut = await Depot.View(
                new QueryInput<TCommonDependence, ViewInput<TCommonDependence>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 20,
                        Page = 1,
                        Filters = [
                            new ViewFilterProperty<TCommonDependence> {
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

    [Theory(DisplayName = "[View]: Using filter Linear Evaluation (OR)")]
    [CommonFactData]
    public async Task ViewF(bool DefaultEdge) {
        Skip.If(Evaluable.PropertyType != typeof(string), "This assertion is only available for entities that have an evaluable string property since CONTAINS method is currently only supported to filter string type properties.");
        TCommonDependence[] entities = await Store(2, (entropy) => WrappedFactory(entropy, DefaultEdge));

        List<object?> possibleValues = [];
        List<IViewFilter<TCommonDependence>> filters = [];

        foreach (TCommonDependence entity in entities) {
            object? sampleValue = Evaluable.GetValue(entity);
            filters.Add(
                    new ViewFilterProperty<TCommonDependence> {
                        Operator = ViewFilterOperators.CONTAINS,
                        Property = Evaluable.Name,
                        Value = sampleValue,
                    }
                );
            possibleValues.Add(sampleValue);
        }
        ViewOutput<TCommonDependence> viewOutput = await Depot.View(
                new QueryInput<TCommonDependence, ViewInput<TCommonDependence>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 20,
                        Page = 1,
                        Filters = [
                            new ViewFilterLogical<TCommonDependence>{
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

    [Theory(DisplayName = "[Read]: Reads an Entity by {Id}.")]
    [CommonFactData]
    public virtual async Task ReadA(bool DefaultEdge) {
        TCommonDependence sample = Store((entropy) => WrappedFactory(entropy, DefaultEdge));

        TCommonDependence readEntity = await Depot.Read(sample.Id);
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

    [Theory(DisplayName = "[Read]: Reads a collection of entities by a collection of {Id}")]
    [CommonFactData]
    public virtual async Task ReadB(bool DefaultEdge) {
        TCommonDependence[] samples = await Store(20, (entropy) => WrappedFactory(entropy, DefaultEdge));
        long[] sampleIds = [.. samples.Select(i => i.Id)];

        BatchOperationOutput<TCommonDependence> readEntities = await Depot.Read(sampleIds);
        Assert.Multiple(
                [
                    () => Assert.Empty(readEntities.Failures),
                    () => Assert.Equal(samples.Length, readEntities.SuccessesCount),
                    () => Assert.All(
                        readEntities.Successes,
                        (entity) => {
                            TCommonDependence sample = samples.First(j => j.Id == entity.Id);

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

    [Theory(DisplayName = "[Read]: Reads for the first entity matching the filter")]
    [CommonFactData]
    public virtual async Task ReadC(bool DefaultEdge) {
        TCommonDependence[] samples = await Store(2, (entropy) => WrappedFactory(entropy, DefaultEdge));
        TCommonDependence samplePivot = samples[0];

        BatchOperationOutput<TCommonDependence> readEntites = await Depot.Read(
                 new QueryInput<TCommonDependence, FilterQueryInput<TCommonDependence>>() {
                     Parameters = new FilterQueryInput<TCommonDependence> {
                         Behavior = FilteringBehaviors.First,
                         Filter = (entity) => entity.Id == samplePivot.Id || entity.Id == samples[1].Id
                     }
                 }
            );

        Assert.Multiple(
                [
                    () => Assert.Empty(readEntites.Failures),
                    () => Assert.Equal(1, readEntites.SuccessesCount),
                    () => {
                        TCommonDependence readEntity = readEntites.Successes[0];

                        Assert.Equal(samplePivot.Id, readEntity.Id);
                        Assert.Equal(samplePivot.Timestamp, readEntity.Timestamp);

                        object? evaluableSampleValue = Evaluable.GetValue(samplePivot);
                        object? evaluableEntityValue = Evaluable.GetValue(readEntity);
                        Assert.Equal(evaluableSampleValue, evaluableEntityValue);
                    },
                ]
            );
    }

    [Theory(DisplayName = "[Read]: Reads for the last entity matching the filter")]
    [CommonFactData]
    public virtual async Task ReadD(bool DefaultEdge) {
        TCommonDependence[] samples = await Store(2, (entropy) => WrappedFactory(entropy, DefaultEdge));
        TCommonDependence samplePivot = samples[1];

        BatchOperationOutput<TCommonDependence> readEntites = await Depot.Read(
               new QueryInput<TCommonDependence, FilterQueryInput<TCommonDependence>>() {
                   Parameters = new FilterQueryInput<TCommonDependence> {
                       Behavior = FilteringBehaviors.Last,
                       Filter = (entity) => entity.Id == samplePivot.Id || entity.Id == samples[0].Id
                   }
               }
            );

        Assert.Multiple(
                [
                    () => Assert.Empty(readEntites.Failures),
                    () => Assert.Equal(1, readEntites.SuccessesCount),
                    () => {
                        TCommonDependence readEntity = readEntites.Successes[0];

                        Assert.Equal(samplePivot.Id, readEntity.Id);
                        Assert.Equal(samplePivot.Timestamp, readEntity.Timestamp);

                        object? evaluableSampleValue = Evaluable.GetValue(samplePivot);
                        object? evaluableEntityValue = Evaluable.GetValue(readEntity);
                        Assert.Equal(evaluableSampleValue, evaluableEntityValue);
                    },
                ]
            );
    }

    [Theory(DisplayName = "[Read]: Reads for all entities matching the filter")]
    [CommonFactData]
    public virtual async Task ReadE(bool DefaultEdge) {
        TCommonDependence[] samples = await Store(2, (entropy) => WrappedFactory(entropy, DefaultEdge));

        BatchOperationOutput<TCommonDependence> readEntites = await Depot.Read(
                new QueryInput<TCommonDependence, FilterQueryInput<TCommonDependence>>() {
                    Parameters = new FilterQueryInput<TCommonDependence> {
                        Behavior = FilteringBehaviors.All,
                        Filter = (entity) => entity.Id == samples[0].Id || entity.Id == samples[1].Id
                    }
                }
            );

        Assert.Multiple(
                [
                    () => Assert.Empty(readEntites.Failures),
                    () => Assert.Equal(2, readEntites.SuccessesCount),
                    () => Assert.All(
                            samples,
                            (sample) => {
                                TCommonDependence entity = readEntites.Successes.First(i => i.Id == sample.Id);

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

    [Theory(DisplayName = "[Create]: Record created and unique store check")]
    [CommonFactData]
    public async Task CreateA(bool DefaultEdge) {
        TCommonDependence sample = Sampling(DefaultEdge);

        TCommonDependence storedEntity = await Depot.Create(sample);
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

    [Theory(DisplayName = "[Create]: Multiple records created")]
    [CommonFactData]
    public async Task CreateB(bool DefaultEdge) {
        TCommonDependence[] samples = Sampling(3, DefaultEdge);

        BatchOperationOutput<TCommonDependence> qOut = await Depot.Create(samples);
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

    [Theory(DisplayName = $"[Update Entity]: Created when Create parameter enabled")]
    [CommonFactData]
    public virtual async Task UpdateA(bool DefaultEdge) {
        TCommonDependence sample = RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge));

        UpdateOutput<TCommonDependence> updateOutput = await Depot.Update(
                new QueryInput<TCommonDependence, UpdateInput<TCommonDependence>> {
                    Parameters = new UpdateInput<TCommonDependence> {
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
                        TCommonDependence overwritten = updateOutput.Updated;

                        Assert.True(overwritten.Id > 0);
                        AssertEvaluable(sample, overwritten);
                    },
                ]
            );
    }

    [Theory(DisplayName = $"[Update Entity]: Throws CreateDisabled exception situation.")]
    [CommonFactData]
    public virtual async Task UpdateB(bool DefaultEdge) {
        TCommonDependence sample = RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge));

        XDepot<TCommonDependence> depotException = await Assert.ThrowsAsync<XDepot<TCommonDependence>>(
                async () => {
                    UpdateOutput<TCommonDependence> updateOutput = await Depot.Update(
                new QueryInput<TCommonDependence, UpdateInput<TCommonDependence>> {
                    Parameters = new UpdateInput<TCommonDependence> {
                        Entity = sample,
                    },
                }
                    );
                }
            );

        Assert.Equal(XDepotSituations.CreateDisabled, depotException.Reason);
    }

    [Theory(DisplayName = $"[Update Entity]: Throws Unfound exception situation")]
    [CommonFactData]
    public virtual async Task UpdateC(bool DefaultEdge) {
        TCommonDependence sample = RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge));
        sample.Id = await GeneratePointer();

        XDepot<TCommonDependence> depotException = await Assert.ThrowsAsync<XDepot<TCommonDependence>>(
                async () => {
                    UpdateOutput<TCommonDependence> updateOutput = await Depot.Update(
                        new QueryInput<TCommonDependence, UpdateInput<TCommonDependence>> {
                            Parameters = new UpdateInput<TCommonDependence> {
                                Entity = sample,
                            },
                        }
                    );
                }
            );
        Assert.Equal(XDepotSituations.Unfound, depotException.Reason);
    }

    [Theory(DisplayName = $"[Update Entity]: Entity gets updated correctly")]
    [CommonFactData]
    public virtual async Task UpdateD(bool DefaultEdge) {
        TCommonDependence sample = Store((entropy) => WrappedFactory(entropy, DefaultEdge));
        TCommonDependence valueReference = RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge));

        object? sampleOriginalValue = Evaluable.GetValue(sample);

        Evaluable.SetValue(sample, Evaluable.GetValue(valueReference));

        UpdateOutput<TCommonDependence> updateOutput = await Depot.Update(
                new QueryInput<TCommonDependence, UpdateInput<TCommonDependence>> {
                    Parameters = new UpdateInput<TCommonDependence> {
                        Entity = sample,
                    },
                }
            );

        Assert.Multiple(
                [
                    () => Assert.NotNull(updateOutput.Original),
                    () => {
                        TCommonDependence overwritten = updateOutput.Updated;

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

        XDepot<TCommonDependence> depotException = await Assert.ThrowsAsync<XDepot<TCommonDependence>>(
                async () => {
                    await Depot.Delete(unexistPointer);
                }
            );

        Assert.Equal(XDepotSituations.Unfound, depotException.Reason);
    }

    [Theory(DisplayName = $"[Delete Entity]: Deletes correctly an Entity with a given Common Entity")]
    [CommonFactData]
    public virtual async Task DeleteB(bool DefaultEdge) {
        TCommonDependence entity = Store((entropy) => WrappedFactory(entropy, DefaultEdge));

        await Depot.Delete(entity);
        await CommitSampleEntities([]);

        TCommonDependence? searchedEntity = Database.Set<TCommonDependence>().Find(entity.Id);
        Assert.Null(searchedEntity);
    }


    #endregion

}