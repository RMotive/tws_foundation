using System.ComponentModel.DataAnnotations;
using System.Reflection;

using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Core.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Models;
using CSM_Foundation.Database.Utilitites;
using CSM_Foundation.Server.Managers;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Foundation.Database.Bases;

/// <summary>
/// 
/// </summary>
public static class EntityTypeBuilderExtension {
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Builder"></param>
    /// <param name="Relation"></param>
    /// <param name="SourceReference"></param>
    /// <param name="Required"></param>
    /// <param name="Auto"></param>
    /// <param name="Deletion"></param>
    public static void Link(this EntityTypeBuilder Builder, (Type Source, Type Target) Relation, string SourceReference, string? TargetReference = null, bool Required = false, bool Auto = false, bool Index = false, DeleteBehavior Deletion = DeleteBehavior.Restrict) {
        Type entityIType = typeof(IEntity);
        Type source = Relation.Source;
        Type target = Relation.Target;

        if (!(source.IsAssignableTo(entityIType) && target.IsAssignableTo(entityIType))) {
            throw new Exception($"[SourceT ({source.Name})] or [Target ({target.Name})] Relation configuration is not an [IEntity]");
        }
        PropertyInfo sourceNavigation = source.GetProperty(SourceReference)
            ?? throw new Exception($"[Source {source.Name}] doesn't contain navigation reference ({SourceReference})");
        if (sourceNavigation.PropertyType.IsGenericType && sourceNavigation.PropertyType.GetGenericTypeDefinition() == typeof(ICollection<>)) {
            throw new Exception($"This method only supports one to on/many relationship for many-to-many use ({1})");
        }

        string targetReference = TargetReference ?? $"{source.Name}";
        PropertyInfo? targetNavigation = target.GetProperty(targetReference);
        if (TargetReference == null && targetNavigation == null) {
            targetReference = $"{source.Name}s";
            targetNavigation = target.GetProperty(targetReference);
        }
        string shadowProperty = $"{SourceReference}Shadow";

        Type propType = Required ? typeof(long) : typeof(long?);
        Builder.Property(propType, shadowProperty).HasColumnName(SourceReference).HasColumnType("bigint").IsRequired(Required);

        ReferenceNavigationBuilder relationBuilder = Builder.HasOne(target, SourceReference);
        if (targetNavigation != null && targetNavigation.PropertyType.IsGenericType && targetNavigation.PropertyType.GetGenericTypeDefinition() == typeof(ICollection<>)) {
            relationBuilder.WithMany(targetReference).HasForeignKey(shadowProperty).OnDelete(Deletion).IsRequired(Required);
        } else {

            relationBuilder.WithOne(targetNavigation is null ? null : targetReference).HasForeignKey(source, shadowProperty).OnDelete(Deletion).IsRequired(Required);
        }

        if (Auto) {
            Builder.Navigation(SourceReference).AutoInclude();
        }

        if (Index && Required) {
            Builder.HasIndex(shadowProperty).IsUnique();
        }
    }
    /// <summary>
    ///     
    /// </summary>
    /// <typeparam name="SourceT"></typeparam>
    /// <typeparam name="TargetT"></typeparam>
    /// <param name="Builder"></param>
    /// <param name="SourceReference"></param>
    /// <param name="Required"></param>
    /// <param name="Auto"></param>
    /// <param name="Deletion"></param>
    public static void Link<SourceT, TargetT>(this EntityTypeBuilder Builder, string SourceReference, string? TargetReference = null, bool Required = false, bool Auto = false, bool Index = false, DeleteBehavior Deletion = DeleteBehavior.Restrict)
        where SourceT : class, IEntity
        where TargetT : class, IEntity {

        Link(
                Builder,
                (typeof(SourceT), typeof(TargetT)),
                SourceReference: SourceReference,
                TargetReference: TargetReference,
                Required: Required,
                Auto: Auto,
                Index: Index,
                Deletion: Deletion
            );
    }
}

/// <summary>
///     [Abstract] for a SQL Server database implementation, a [CSM] custom wrapper from <see cref="DbContext"/> EntityFrameworkCore
///     to simplify its utilization based on own requirements.
/// </summary>
/// <typeparam name="TDatabases">
///     Runtime Type of the <see cref="DbContext"/> implementation to handle
/// </typeparam>
public abstract partial class BDatabase_SQLServer<TDatabases>
    : DbContext, IDatabase
    where TDatabases : DbContext {

    /// <summary>
    ///     Data storage connection options.
    /// </summary>
    protected readonly ConnectionOptions Connection;

    /// <summary>
    ///     [MaxLength 5] Server sign identificator (needed for transactions and authorization processes).
    /// </summary>
    [StringLength(5, MinimumLength = 5)]
    protected string Sign {
        get => _Sign; init => _Sign = value.ToUpper();
    }
    string _Sign = "";

    /// <summary>
    ///     Generates a <see cref="BDatabase_SQLServer{TDatabases}"/> instance that handles specific database connection
    ///     and configuration properties/methods. 
    /// </summary>
    /// <param name="Sign">
    ///     Database implementation signature to identify.
    /// </param>
    /// <remarks> 
    ///     This method gathers the <see cref="Connection"/> options from ./<see cref="Sign"/>(Upper)>/*.json files automatically.
    /// </remarks>
    public BDatabase_SQLServer([StringLength(5, MinimumLength = 5)] string Sign)
        : base() {

        this.Sign = Sign;
        Connection = DatabaseUtilities.Retrieve(this.Sign);
    }

    /// <summary>
    ///     Generates a <see cref="BDatabase_SQLServer{TDatabases}"/> instance that handles specific database connection
    ///     and configuration properties/methods. 
    /// </summary>
    /// <param name="Sign">
    ///     Database implementation signature to identify.
    /// </param>
    /// <param name="Connection">
    ///     Database connection options.
    /// </param>
    public BDatabase_SQLServer([StringLength(5, MinimumLength = 5)] string Sign, ConnectionOptions Connection)
        : base() {

        this.Sign = Sign;
        this.Connection = Connection;
    }

    /// <summary>
    ///     Generates a <see cref="BDatabase_SQLServer{TDatabases}"/> instance that handles specific database connection
    ///     and configuration properties/methods. 
    /// </summary>
    /// <param name="Sign">
    ///     Database implementation signature to identify
    /// </param>
    /// <param name="Options">
    ///     Native EntityFrameworkCore <see cref="DbContext"/> implementation options.
    /// </param>
    /// <remarks> 
    ///     This method gathers the <see cref="Connection"/> options from ./<see cref="Sign"/>(Upper)>/*.json files automatically.
    /// </remarks>
    public BDatabase_SQLServer([StringLength(5, MinimumLength = 5)] string Sign, DbContextOptions<TDatabases> Options)
        : base(Options) {

        this.Sign = Sign;
        Connection = DatabaseUtilities.Retrieve(this.Sign);
    }

    /// <summary>
    ///     Generates a <see cref="BDatabase_SQLServer{TDatabases}"/> instance that handles specific database connection
    ///     and configuration properties/methods. 
    /// </summary>
    /// <param name="Sign">
    ///     Database implementation signature to identify
    /// </param>
    /// <param name="Connection">
    ///     Database connection options.
    /// </param>
    /// <param name="Options">
    ///     Native EntityFrameworkCore <see cref="DbContext"/> implementation options.
    /// </param>
    public BDatabase_SQLServer([StringLength(5, MinimumLength = 5)] string Sign, ConnectionOptions Connection, DbContextOptions<TDatabases> Options)
        : base(Options) {

        this.Sign = Sign;
        this.Connection = Connection;
    }

    /// <summary>
    ///     Validates if all the <see cref="Sets"/> <see cref="Type"/>s are <see cref="BEntity"/> assuring contains the correct
    ///     methods needed.
    /// </summary>
    /// <returns>
    ///     The strict validated collection of [<see cref="BBusinessDatabaseEntity"/>]s and [<see cref="BConnector{TSource, TTarget}"/>]s.
    /// </returns>
    BEntity[] ValidateSets() {
        Type databaseType = GetType();

        List<BEntity> sets = [];
        IEnumerable<PropertyInfo> dbSets = databaseType
           .GetProperties()
           .Where(
               (propInfo) => {
                   Type propType = propInfo.PropertyType;

                   return propType.IsGenericType && propType.GetGenericTypeDefinition() == typeof(DbSet<>);
               }
           );

        foreach (PropertyInfo dbSet in dbSets) {
            Type generic = dbSet.PropertyType.GetGenericArguments()[0]
                ?? throw new Exception($"DBSet [{dbSet.Name}] generic gathering failure");

            sets.Add((BEntity)Activator.CreateInstance(generic)!);
        }

        return [..sets];
    }

    /// <summary>
    ///     Validates database connection health.
    /// </summary>
    public void ValidateConnection() {
        AdvisorManager.Announce($"ORM Setting up *^____^*", new() {
            {"Database", GetType()?.Namespace ?? "---" },
            {"Base", nameof(BDatabase_SQLServer<TDatabases>) }
        });

        if (Database.CanConnect()) {
            AdvisorManager.Success($"[{GetType().Name}] Connection stable");
            Evaluate();
        } else {
            try {
                Database.OpenConnection();
            } catch (Exception ex) {

                throw new Exception($"Invalid connection with Database ({GetType().Name}) | {ex.InnerException?.Message}");
            }
        }
    }

    /// <summary>
    ///     Evaluates if <see cref="Sets"/> are correctly configured and translated to the internal framework handler.
    /// </summary>
    public void Evaluate() {
        BEntity[] sets = ValidateSets();

        AdvisorManager.Announce(
            $"[{GetType().Name}] Validatig Sets...",
            new() {
                { "Count", sets.Length }
            }
        );

        Exception[] evResults = [];
        foreach (BEntity set in sets) {
            Exception[] result = set.EvaluateDefinition();
            if (result.Length > 0) {
                AdvisorManager.Warning(
                    "Wrong [Set] definition",
                    new() {
                        { "Set", set.GetType().Name },
                        { "Exceptions", result },
                    }
                );
            }

            evResults = [.. evResults, .. result];
        }

        if (evResults.Length > 0) {
            throw new Exception("Database [Set] definition failures");
        } else {
            AdvisorManager.Success($"[{GetType().Name}] Set validation succeeded");
        }
    }


    #region EF Native Methods

    protected virtual void EvaluateCustom(BEntity Entity, EntityTypeBuilder mBuilder) { }

    /// <summary>
    ///     This is overriden from <see cref="BDatabase_SQLServer{TDatabases}"/> to Configure an SQL Server Connection using
    ///     <see cref="Connection"/> generated string, this natively has another behavior but using <see cref="BDatabase_SQLServer{TDatabases}"/>
    ///     will automatically configure the SQL Server connection.
    /// </summary>
    /// <param name="optionsBuilder">
    ///     Relations builder proxy object.
    /// </param>
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) {
        string connectionString = Connection.GenerateConnectionString();
        optionsBuilder.UseSqlServer(connectionString);

        if (AppDomain.CurrentDomain.FriendlyName.Contains("ef")) {
            AdvisorManager.Warning(
                    $"Running EF Design Time Execution",
                    new Dictionary<string, dynamic> {
                        { "Environment", EnvironmentManager.Mode.ToString() },
                        { "Connection", connectionString },
                    }
                );
        }
    }

    protected override void OnModelCreating(ModelBuilder mBuilder) {

        IEnumerable<IMutableEntityType> entityTypes = mBuilder.Model.GetEntityTypes();
        foreach (IMutableEntityType entityType in entityTypes) {

            IEnumerable<IMutableForeignKey> foreignKeys = [.. entityType.GetForeignKeys()];
            foreach (IMutableForeignKey foreignKey in foreignKeys) {

                if (foreignKey.DependentToPrincipal is null) {
                    continue;
                }

                mBuilder.Entity(entityType.ClrType).Ignore(foreignKey.DependentToPrincipal.Name);
            }
        }

        BEntity[] sets = ValidateSets();

        foreach (BEntity set in sets) {
            Type setType = set.GetType();
            mBuilder.Entity(
                setType,
                (etBuilder) => {
                    etBuilder.HasKey(nameof(IEntity.Id));
                    etBuilder.Property<long>(nameof(IEntity.Id)).IsRequired();

                    if (set is IEntity_Name) {
                        PropertyInfo nameProperty = set.GetProperty(nameof(IEntity_Name.Name));
                        PropertyInfo descriptionProperty = set.GetProperty(nameof(IEntity_Name.Description));

                        etBuilder.HasIndex(nameProperty.Name).IsUnique();
                        etBuilder.Property(nameProperty.Name).HasMaxLength(100).IsRequired();

                        etBuilder.Property(descriptionProperty.Name).HasMaxLength(200);
                    }


                    bool HasCommonDefinition() {
                        Type? evalType = setType;

                        while (evalType != null) {
                            if (evalType.IsGenericType && evalType.GetGenericTypeDefinition() == typeof(BEntity<>)) {
                                return true;
                            }

                            evalType = evalType.BaseType;
                        }

                        return false;
                    }

                    if (HasCommonDefinition()) {
                        PropertyInfo commonProperty = set.GetProperty(nameof(BEntity<IEntity>.Common));
                        Type commonType = commonProperty.PropertyType;
                        PropertyInfo commonTypeTargetProp = commonType
                            .GetProperties()
                            .Where(i => i.PropertyType == setType)
                            .FirstOrDefault()
                            ?? throw new Exception($"Unable to find [Common relation type ({commonType}) property with the same source type ({setType})]");

                        etBuilder.Link(
                                Relation: (setType, commonType),
                                SourceReference: commonProperty.Name,
                                TargetReference: commonTypeTargetProp.Name,
                                Required: true,
                                Auto: true,
                                Index: true
                            );
                    }

                    EvaluateCustom(set, etBuilder);

                    etBuilder.Property(nameof(IEntity.Timestamp)).HasColumnType("datetime2(7)").HasDefaultValueSql("GETUTCDATE()");

                    set.DesignEntity(etBuilder);
                }
            );
        }

        base.OnModelCreating(mBuilder);
    }

    #endregion
}

/// <summary>
///     [Abstract] Partial implementation to expose generation/validation methods to <see cref="BDatabase_SQLServer{TDatabases}"/> handler.
/// </summary>
public abstract partial class BEntity
    : BObject<IEntity>, IEntity {

    /// <summary>
    ///     Describe to the Entity Framework manager how to handle the [Entity] object, its proeprties and relations, instructing
    ///     the <see cref="EntityTypeBuilder"/> how to handle them.
    /// </summary>
    /// <param name="etBuilder">
    ///     Proxy object to configure Entity Model to Entity Framework Core.
    /// </param>
    /// <remarks>
    ///     Don't describe <see cref="IEntity"/> properties they are being auto-described by the [CSM] engine, <see cref="IEntity.Id"/>, <see cref="IEntity.Timestamp"/> and <see cref="IEntity.Name"/>.
    /// </remarks>
    protected internal virtual void DesignEntity(EntityTypeBuilder etBuilder) { }
}