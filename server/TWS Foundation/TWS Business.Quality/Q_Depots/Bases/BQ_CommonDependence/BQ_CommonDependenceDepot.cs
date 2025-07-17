using System.Linq.Expressions;
using System.Reflection;

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
using TWS_Business.Quality.Q_Depots.Q_Validators;

using BEntity = TWS_Business.BEntity;

namespace CSM_Foundation.Database.Quality;

public abstract class BQ_CommonDependenceDepot<TDepot, TDatabase, TEntity>
    : BQ_DataHandler
    where TEntity : BEntity, new()
    where TDepot : BDepot<TDatabase, TEntity>
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
    public BQ_CommonDependenceDepot(string Sign, DatabaseFactory? Database = null, params DatabaseFactory[] Factories)
        : base(
            [
                ..Factories,
                () => Database?.Invoke() ?? DatabaseUtilities.Q_Construct<TDatabase>(Sign)
            ]
        ) {

        this.Database = (TDatabase)(Database?.Invoke() ?? DatabaseUtilities.Q_Construct<TDatabase>(Sign));
        Depot = (TDepot)Activator.CreateInstance(typeof(TDepot), this.Database, null)!;

        PropertyInfo[] entityProperties = typeof(TEntity).GetProperties();

        PropertyInfo? orderableTmp = null;
        foreach (PropertyInfo propertyInfo in entityProperties) {

            Type propertyType = propertyInfo.PropertyType;

            if (((propertyType != typeof(string)) && (propertyType != typeof(int))) || (propertyInfo.Name == nameof(IEntity.Discriminator))) {
                continue;
            }

            orderableTmp = propertyInfo;
            break;
        }

        Evaluable = orderableTmp ?? typeof(TEntity).GetProperty(nameof(IEntity.Id))!; // By default if the [Entity] doesn't have a valid evaluable property will use the Id. 
    }

    #region Abtraction

    /// <summary>
    ///     Creates a context [Entity] for testing data creation and assertion.
    /// </summary>
    /// <param name="entropy">
    ///     Random 16 length value for unique properties.
    /// </param>
    /// <returns>
    ///     A correctly built <see cref="TEntity"/>.
    /// </returns>
    protected abstract TEntity EntityFactory(string entropy);

    protected abstract TEntity ComposedEntity(TEntity entity);

    #endregion

    #region Private / Protected Functions

    /// <summary>
    ///  True when the given <paramref name="type"/> is derived from the given <paramref name="genericBase"/> type.
    ///  Implemented to check for CommonEntity dependencies.
    /// </summary>
    /// <param name="type"></param>
    /// <param name="genericBase"></param>
    /// <returns></returns>
    private bool IsDerivedFromGenericBase(Type type, Type genericBase) {
        while (type != null && type != typeof(object)) {
            if (type.IsGenericType && type.GetGenericTypeDefinition() == genericBase)
                return true;

            type = type.BaseType!;
        }
        return false;
    }


    /// <summary>
    /// Loads and initializes dependencies for the specified common dependent entity based on its properties.
    /// </summary>
    /// <remarks>This method scans the properties of the specified entity to identify dependencies marked with
    /// <see cref="RelationAttribute"/> and inheriting from <c>CommonEntity&lt;,&gt;</c>. It then uses the appropriate
    /// dependency creation method, either internal or external, based on the value of <paramref name="isInternal"/>. If
    /// a property does not meet the required criteria, an exception is thrown.</remarks>
    /// 
    /// <param name="entropy">A string value used as input for dependency creation. This is typically required by the dependency creation
    /// methods to generate or configure the dependencies.</param>
    /// 
    /// <param name="isInternal">A boolean value indicating whether internal or external dependencies should be created. If <see
    /// langword="true"/>, internal dependencies are created; otherwise, external dependencies are created.</param>
    /// 
    /// <param name="entity">The entity for which dependencies are to be loaded. The entity must have properties marked with <see
    /// cref="RelationAttribute"/> and inheriting from <c>CommonEntity&lt;,&gt;</c>.</param>
    /// 
    /// <exception cref="InvalidOperationException">Thrown if no properties in the entity are marked with <see cref="RelationAttribute"/> and inherit from
    /// <c>CommonEntity&lt;,&gt;</c>, or if a property marked with <see cref="RelationAttribute"/> does not have a valid
    /// <c>BAdapterAttribute&lt;,,&gt;</c> for dependency creation.</exception>
    private void LoadDependencies(string entropy, bool isInternal, TEntity entity) {
        // Get all common properties in main entity.
        IEnumerable<PropertyInfo> commonDependencies = typeof(TEntity)
            .GetProperties()
            .Where(pi =>
                pi.GetCustomAttribute<RelationAttribute>() != null &&
                IsDerivedFromGenericBase(pi.PropertyType, typeof(CommonEntity<,>))
            ).ToList();

        if (!commonDependencies.Any()) throw new InvalidOperationException($"No common dependencies found in {typeof(TEntity).Name}. Ensure properties are marked with RelationAttribute and inherit from CommonEntity<,>.");

        // Generate commonDependencies.
        foreach (PropertyInfo prop in commonDependencies) {
            var attribute = prop.GetCustomAttributes(inherit: true)
                        .FirstOrDefault(pi => IsDerivedFromGenericBase(pi.GetType(), typeof(BAdapterAttribute<,,>)));

            if (attribute != null) {
                MethodInfo createMethod;
                if (isInternal) {
                    createMethod = attribute.GetType().GetMethod("CreateInternal")!;
                    prop.SetValue(entity, createMethod.Invoke(attribute, [entropy]));
                } else {
                    createMethod = attribute.GetType().GetMethod("CreateExternal")!;
                    prop.SetValue(entity, createMethod.Invoke(attribute, [entropy]));
                }
                continue;
            }

            throw new InvalidOperationException($"Property {prop.Name} in {typeof(TEntity).Name} is marked with RelationAttribute but does not have a valid BAdapterAttribute for dependency creation.");

        }

    }
    
    /// <summary>
    /// Creates and returns an entity after applying additional composition and loading dependencies.
    /// </summary>
    /// <param name="entropy">A string used to generate the initial entity and load its dependencies. Cannot be null or empty.</param>
    /// <param name="isInternal">A boolean indicating whether the dependencies should be loaded in internal mode.  <see langword="true"/> for
    /// internal mode; otherwise, <see langword="false"/>.</param>
    /// <returns>The fully composed entity with all dependencies loaded.</returns>
    private TEntity WrappedFactory(string entropy, bool isInternal) {
        TEntity commonDependent = EntityFactory(entropy);
        LoadDependencies(entropy, isInternal, commonDependent);
        commonDependent = ComposedEntity(commonDependent);

        return commonDependent;
    }

    /// <summary>
    ///     
    /// </summary>
    /// <param name="SampleEntities"></param>
    protected async Task CommitSampleEntities(ICollection<TEntity> SampleEntities) {
        await Database.SaveChangesAsync();
        foreach (TEntity commonDependent in SampleEntities.Reverse()) {
            Disposer.Push(commonDependent);
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="expected"></param>
    /// <param name="actual"></param>
    protected void AssertEvaluable(TEntity expected, TEntity actual) {
        object? sampleEvaluableValue = Evaluable.GetValue(expected);
        object? overwrittenEvaluableValue = Evaluable.GetValue(actual);

        Assert.Equal(sampleEvaluableValue, overwrittenEvaluableValue);
    }

    /// <summary>
    ///     Looks into the database for a random <see cref="IEntity.Id"/> that hasn't been used yet.
    /// </summary>
    /// <param name="noStored">
    ///     Wheter the generator should verify the generated <see cref="IEntity.Id"/> isn't used
    ///     for a stored <typeparamref name="TEntity"/> yet.
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
            iteratorLock = await Database.Set<TEntity>().FindAsync(randomLong) is not null;
        } while (iteratorLock);

        return randomLong;
    }

    #endregion

    #region Sampling

    /// <summary>
    ///     Creates a new <see cref="TEntity"/> instance based on the <see cref="EntityFactory(string)"/> implementation.
    /// </summary>
    /// <returns> A new <see cref="TEntity"/> instance </returns>
    /// <remarks>
    ///     This <see cref="IEntity"/> instance is created but not stored in the database.
    /// </remarks>
    protected TEntity Sampling(bool DefaultEdge) {
        return RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge));
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
    protected TEntity[] Sampling(int Count, bool DefaultEdge) {
        return [.. Enumerable.Range(0, Count).Select(_ => RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge)))];
    }

    #endregion


    #region Q_Base View

    [Theory(DisplayName = "[View]: Simple view calculation"), CommonFactData]
    public async Task ViewA(bool DefaultEdge) {
        const int viewPage = 1;
        await Store(30, (entropy) => WrappedFactory(entropy, DefaultEdge));

        ViewOutput<TEntity> viewOutput = await Depot.View(
                new QueryInput<TEntity, ViewInput<TEntity>> {
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

        ViewOutput<TEntity> viewOutput = await Depot.View(
                new QueryInput<TEntity, ViewInput<TEntity>> {
                    Parameters = new ViewInput<TEntity> {
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

        ViewOutput<TEntity> orderedViewOutput = await Depot.View(
                        new QueryInput<TEntity, ViewInput<TEntity>> {
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
        TEntity[] orderedReferenceRecords = [.. orderedViewOutput.Entities];
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
            TEntity actual = orderedViewOutput.Entities[i];

            Assert.Equal(Evaluable.GetValue(expected), Evaluable.GetValue(actual));
        }
    }

    [Fact(DisplayName = "[View]: Using Date filter")]
    public async Task ViewD() {
        ViewOutput<TEntity> viewOutput = await Depot.View(
                new QueryInput<TEntity, ViewInput<TEntity>> {
                    Parameters = new() {
                        Page = 1,
                        Range = 20,
                        Retroactive = false,
                        Filters = [
                            new ViewFilterDate<TEntity> {
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

        TEntity sampleEntity = Store((entropy) => WrappedFactory(entropy, DefaultEdge));
        object? sampleValue = Evaluable.GetValue(sampleEntity);
        ViewOutput<TEntity> qOut = await Depot.View(
                new QueryInput<TEntity, ViewInput<TEntity>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 20,
                        Page = 1,
                        Filters = [
                            new ViewFilterProperty<TEntity> {
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
        TEntity[] entities = await Store(2, (entropy) => WrappedFactory(entropy, DefaultEdge));

        List<object?> possibleValues = [];
        List<IViewFilter<TEntity>> filters = [];

        foreach (TEntity entity in entities) {
            object? sampleValue = Evaluable.GetValue(entity);
            filters.Add(
                    new ViewFilterProperty<TEntity> {
                        Operator = ViewFilterOperators.CONTAINS,
                        Property = Evaluable.Name,
                        Value = sampleValue,
                    }
                );
            possibleValues.Add(sampleValue);
        }
        ViewOutput<TEntity> viewOutput = await Depot.View(
                new QueryInput<TEntity, ViewInput<TEntity>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 20,
                        Page = 1,
                        Filters = [
                            new ViewFilterLogical<TEntity>{
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
        TEntity sample = Store((entropy) => WrappedFactory(entropy, DefaultEdge));

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

    [Theory(DisplayName = "[Read]: Reads a collection of entities by a collection of {Id}")]
    [CommonFactData]
    public virtual async Task ReadB(bool DefaultEdge) {
        TEntity[] samples = await Store(20, (entropy) => WrappedFactory(entropy, DefaultEdge));
        long[] sampleIds = [.. samples.Select(i => i.Id)];

        BatchOperationOutput<TEntity> readEntities = await Depot.Read(sampleIds);
        Assert.Multiple(
                [
                    () => Assert.Empty(readEntities.Failures),
                    () => Assert.Equal(samples.Length, readEntities.SuccessesCount),
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

    [Theory(DisplayName = "[Read]: Reads for the first entity matching the filter")]
    [CommonFactData]
    public virtual async Task ReadC(bool DefaultEdge) {
        TEntity[] samples = await Store(2, (entropy) => WrappedFactory(entropy, DefaultEdge));
        TEntity samplePivot = samples[0];

        BatchOperationOutput<TEntity> readEntites = await Depot.Read(
                 new QueryInput<TEntity, FilterQueryInput<TEntity>>() {
                     Parameters = new FilterQueryInput<TEntity> {
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

    [Theory(DisplayName = "[Read]: Reads for the last entity matching the filter")]
    [CommonFactData]
    public virtual async Task ReadD(bool DefaultEdge) {
        TEntity[] samples = await Store(2, (entropy) => WrappedFactory(entropy, DefaultEdge));
        TEntity samplePivot = samples[1];

        BatchOperationOutput<TEntity> readEntites = await Depot.Read(
               new QueryInput<TEntity, FilterQueryInput<TEntity>>() {
                   Parameters = new FilterQueryInput<TEntity> {
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

    [Theory(DisplayName = "[Read]: Reads for all entities matching the filter")]
    [CommonFactData]
    public virtual async Task ReadE(bool DefaultEdge) {
        TEntity[] samples = await Store(2, (entropy) => WrappedFactory(entropy, DefaultEdge));

        BatchOperationOutput<TEntity> readEntites = await Depot.Read(
                new QueryInput<TEntity, FilterQueryInput<TEntity>>() {
                    Parameters = new FilterQueryInput<TEntity> {
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

    #region Q_Base Create

    [Theory(DisplayName = "[Create]: Record created and unique store check")]
    [CommonFactData]
    public async Task CreateA(bool DefaultEdge) {
        TEntity sample = Sampling(DefaultEdge);

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

    [Theory(DisplayName = "[Create]: Multiple records created")]
    [CommonFactData]
    public async Task CreateB(bool DefaultEdge) {
        TEntity[] samples = Sampling(3, DefaultEdge);

        BatchOperationOutput<TEntity> qOut = await Depot.Create(samples);
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
        TEntity sample = RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge));

        UpdateOutput<TEntity> updateOutput = await Depot.Update(
                new QueryInput<TEntity, UpdateInput<TEntity>> {
                    Parameters = new UpdateInput<TEntity> {
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
                        TEntity overwritten = updateOutput.Updated;

                        Assert.True(overwritten.Id > 0);
                        AssertEvaluable(sample, overwritten);
                    },
                ]
            );
    }

    [Theory(DisplayName = $"[Update Entity]: Throws CreateDisabled exception situation.")]
    [CommonFactData]
    public virtual async Task UpdateB(bool DefaultEdge) {
        TEntity sample = RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge));

        XDepot<TEntity> depotException = await Assert.ThrowsAsync<XDepot<TEntity>>(
                async () => {
                    UpdateOutput<TEntity> updateOutput = await Depot.Update(
                new QueryInput<TEntity, UpdateInput<TEntity>> {
                    Parameters = new UpdateInput<TEntity> {
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
        TEntity sample = RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge));
        sample.Id = await GeneratePointer();

        XDepot<TEntity> depotException = await Assert.ThrowsAsync<XDepot<TEntity>>(
                async () => {
                    UpdateOutput<TEntity> updateOutput = await Depot.Update(
                        new QueryInput<TEntity, UpdateInput<TEntity>> {
                            Parameters = new UpdateInput<TEntity> {
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
        TEntity sample = Store((entropy) => WrappedFactory(entropy, DefaultEdge));
        TEntity valueReference = RunEntityFactory((entropy) => WrappedFactory(entropy, DefaultEdge));

        object? sampleOriginalValue = Evaluable.GetValue(sample);

        Evaluable.SetValue(sample, Evaluable.GetValue(valueReference));

        UpdateOutput<TEntity> updateOutput = await Depot.Update(
                new QueryInput<TEntity, UpdateInput<TEntity>> {
                    Parameters = new UpdateInput<TEntity> {
                        Entity = sample,
                    },
                }
            );

        Assert.Multiple(
                [
                    () => Assert.NotNull(updateOutput.Original),
                    () => {
                        TEntity overwritten = updateOutput.Updated;

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

        XDepot<TEntity> depotException = await Assert.ThrowsAsync<XDepot<TEntity>>(
                async () => {
                    await Depot.Delete(unexistPointer);
                }
            );

        Assert.Equal(XDepotSituations.Unfound, depotException.Reason);
    }

    [Theory(DisplayName = $"[Delete Entity]: Deletes correctly an Entity with a given Common Entity")]
    [CommonFactData]
    public virtual async Task DeleteB(bool DefaultEdge) {
        TEntity entity = Store((entropy) => WrappedFactory(entropy, DefaultEdge));

        await Depot.Delete(entity);
        await CommitSampleEntities([]);

        TEntity? searchedEntity = Database.Set<TEntity>().Find(entity.Id);
        Assert.Null(searchedEntity);
    }


    #endregion

}