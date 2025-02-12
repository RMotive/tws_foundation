using System.ComponentModel.DataAnnotations;
using System.Reflection;

using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Core.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Utilitites;

using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Database.Bases;

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
    protected readonly DatabasesLinkOptions Connection;

    /// <summary>
    ///     [MaxLength 5] Server sign identificator (needed for transactions and authorization processes).
    /// </summary>
    [StringLength(5, MinimumLength = 5)]
    protected string Sign {
        get => _Sign;
        init {
            _Sign = value.ToUpper();
        }
    }
    private string _Sign = "";

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
    public BDatabase_SQLServer([StringLength(5, MinimumLength = 5)] string Sign, DatabasesLinkOptions Connection)
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
    public BDatabase_SQLServer([StringLength(5, MinimumLength = 5)] string Sign, DatabasesLinkOptions Connection, DbContextOptions<TDatabases> Options)
        : base(Options) {

        this.Sign = Sign;
        this.Connection = Connection;
    }

    /// <summary>
    ///     Validates if all the <see cref="Sets"/> <see cref="Type"/>s are <see cref="BSet"/> assuring contains the correct
    ///     methods needed.
    /// </summary>
    /// <returns>
    ///     The strict validated collection of [<see cref="BSet"/>]s and [<see cref="BConnector{TSource, TTarget}"/>]s.
    /// </returns>
    private (BSet[] Sets, BConnector<ISet, ISet>[] Connectors) ValidateSets() {
        Type databaseType = GetType();

        BSet[] sets = [];
        BConnector<ISet, ISet>[] connectors = [];
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

            bool isSet = generic.IsAssignableTo(typeof(BSet));
            bool isConnector = generic.IsAssignableTo(typeof(BConnector<,>));

            if (!(isSet || isConnector))
                throw new Exception($"BSet [{dbSet.Name}] doesn't implement the correct bases (BSet || BConnector) unable to define its function");

            if (isSet) {
                sets = [
                        ..sets,
                        (BSet)Activator.CreateInstance(generic)!,
                    ];
            } else {
                connectors = [
                        (BConnector<ISet, ISet>)Activator.CreateInstance(generic)!,
                    ];
            }
        }

        return (sets, connectors);
    }

    /// <summary>
    ///     Validates database connection health.
    /// </summary>
    public void ValidateConnection() {
        AdvisorManager.Announce($"ORM Setting up *^____^*", new() {
            {"Database", GetType().Name },
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
        AdvisorManager.Announce($"[{GetType().Name}] Evaluating Records definitions...", new() { { "Count", 0 } });

        (BSet[] sets, _) = ValidateSets();
        Exception[] evResults = [];
        foreach (BSet set in sets) {
            Exception[] result = set.EvaluateDefinition();
            if (result.Length > 0) {
                AdvisorManager.Warning(
                    "Wrong Set definition",
                    new() {
                        { "Set", set.GetType().Name },
                        { "Exceptions", result },
                    }
                );
            }

            evResults = [.. evResults, .. result];
        }

        if (evResults.Length > 0) {
            throw new Exception("Database Records definitions caugth exceptions");
        } else {
            AdvisorManager.Success($"[{GetType().Name}] Records definition evaluation finished");
        }
    }


    #region EF Native Methods

    /// <summary>
    ///     This is overriden from <see cref="BDatabase_SQLServer{TDatabases}"/> to Configure an SQL Server Connection using
    ///     <see cref="Connection"/> generated string, this natively has another behavior but using <see cref="BDatabase_SQLServer{TDatabases}"/>
    ///     will automatically configure the SQL Server connection.
    /// </summary>
    /// <param name="optionsBuilder">
    ///     Options builder proxy object.
    /// </param>
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) {
        string connectionString = Connection.GenerateConnectionString();

        optionsBuilder.UseSqlServer(connectionString);
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder) {
        (BSet[] sets, BConnector<ISet, ISet>[] _) = ValidateSets();

        foreach (BSet set in sets) {
            modelBuilder.Entity(
                set.GetType(),
                (EntityBuilder) => {
                    EntityBuilder.HasKey(nameof(ISet.Id));

                    EntityBuilder
                        .HasIndex(nameof(ISet.Name))
                        .IsUnique();

                    EntityBuilder
                        .Property(nameof(ISet.Name))
                        .HasMaxLength(25)
                        .IsRequired();

                    EntityBuilder
                        .Property(nameof(ISet.Timestamp))
                        .HasColumnType("datetime");
                }
            );

            set.DescribeSet(modelBuilder);
        }

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);

    #endregion
}

/// <summary>
///     [Abstract] Partial implementation to expose generation/validation methods to <see cref="BDatabase_SQLServer{TDatabases}"/> handler.
/// </summary>
public abstract partial class BSet
    : BObject<ISet>, ISet {

    /// <summary>
    ///     Describe to the Entity Framework manager how to handle the [Set] object, its proeprties and relations, instructing
    ///     the <see cref="ModelBuilder"/> how to handle them.
    /// </summary>
    /// <param name="Builder">
    ///     Proxy object to configure Set Model to Entity Framework Core.
    /// </param>
    /// <remarks>
    ///     Don't describe <see cref="ISet"/> properties they are being auto-described by the [CSM] engine, <see cref="ISet.Id"/>, <see cref="ISet.Timestamp"/> and <see cref="ISet.Name"/>.
    /// </remarks>
    protected internal abstract void DescribeSet(ModelBuilder Builder);
}

/// <summary>
///     [Abstract] Partial implementation to expose generation/validation methods to <see cref="BConnector{TSource, TTarget}"/> handler.
/// </summary>
public abstract partial class BConnector<TSource, TTarget>
    : IConnector<TSource, TTarget>
    where TSource : class, ISet
    where TTarget : class, ISet {

    /// <summary>
    ///     Describe to the Entity Framework manager how to handle the [Connector] object, its proeprties, instructing
    ///     the <see cref="ModelBuilder"/> how to handle them.
    /// </summary>
    /// <param name="Builder">
    ///     Proxy object to configure Set Model to Entity Framework Core.
    /// </param>
    /// <remarks>
    ///     [Connector] Description only must describe its properties, ignoring <see cref="BConnector{TSource, TTarget}.Target"/> and <see cref="BConnector{TSource, TTarget}.Source"/> properties implementations.
    ///     They are auto described by the engine.
    /// </remarks>
    protected virtual internal void DescribeConnector(ModelBuilder Builder) { }
}