using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Models;
using CSM_Foundation.Database.Utilitites;

using CSM_Security.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace CSM_Security;


internal class DatabaseDesignFactory
    : IDesignTimeDbContextFactory<Database> {
    public Database CreateDbContext(string[] args) {
        AdvisorManager.Warning("Using native [CSM] design time database context factory");

        ConnectionOptions connectionOptions = DatabaseUtilities.Retrieve("CSMS");

        return new Database(connectionOptions);
    }
}

/// <summary>
///     [Database Context] implementation for [CSM Security] module. Stores necessary information for security and access control to the registered solutions.
/// </summary>
public class Database
    : BDatabase_SQLServer<Database> {

    public const string SIGN = "CSMS";

    /// <summary>
    ///     Creates a new <see cref="Database"/> instance.
    /// </summary>
    /// <param name="Connection">
    ///     Connection parameters information.
    /// </param>
    public Database(ConnectionOptions Connection)
        : base(SIGN, Connection) {
    }

    /// <summary>
    ///     Creates a new <see cref="Database"/> instance.
    /// </summary>
    /// <param name="Connection">
    ///     Connection parameters information.
    /// </param>
    /// <param name="Options">
    ///     Custom EF Native options.
    /// </param>
    public Database(ConnectionOptions Connection, DbContextOptions<Database> Options)
        : base(SIGN, Connection, Options) {
    }

    /// <summary>
    ///     [DbSet] for [<see cref="Account"/>] entities.
    /// </summary>
    public DbSet<Account> Accounts { get; set; } = default!;

    /// <summary>
    ///    [DbSet] for [<see cref="Contact"/>] entities.
    /// </summary>
    public DbSet<Contact> Contacts { get; set; } = default!;

    /// <summary>
    ///   [DbSet] for [<see cref="Feature"/>] entities.
    /// </summary>
    public DbSet<Feature> Features { get; set; } = default!;

    /// <summary>
    ///    [DbSet] for [<see cref="Permit"/>] entities.
    /// </summary>
    public DbSet<Permit> Permits { get; set; } = default!;

    /// <summary>
    ///     [DbSet] for [<see cref="Profile"/>] entities.
    /// </summary>
    public DbSet<Profile> Profiles { get; set; } = default!;

    /// <summary>
    ///     [DbSet] for [<see cref="Solution"/>] entities.
    /// </summary>
    public DbSet<Solution> Solutions { get; set; } = default!;

    /// <summary>
    ///     [DbSet] for [<see cref="Action"/>] entities.
    /// </summary>
    public DbSet<Entities.Action> Actions { get; set; } = default!;
}
