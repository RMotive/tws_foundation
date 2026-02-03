using CSM_Database_Core;
using CSM_Database_Core.Abstractions.Interfaces;
using CSM_Database_Core.Core.Models;
using CSM_Database_Core.Core.Utils;

using CSM_Foundation.Logging;

using CSM_Security.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace CSM_Security;


internal class DatabaseDesignFactory
    : IDesignTimeDbContextFactory<Database> {
    public Database CreateDbContext(string[] args) {
        Logger.Warning("Using native [CSM] design time database context factory");

        ConnectionOptions connectionOptions = DatabaseUtils.GetConnectionOptions("CSMS");

        return new Database(connectionOptions);
    }
}

/// <summary>
///     [Database Context] implementation for [CSM Security] module. Stores necessary information for security and access control to the registered solutions.
/// </summary>
public class Database
    : DatabaseBase<Database>, IDatabase {

    public override string Sign => "CSMS";

    /// <summary>
    ///     Creates a new <see cref="Database"/> instance.
    /// </summary>
    /// <param name="Connection">
    ///     Connection parameters information.
    /// </param>
    public Database(ConnectionOptions Connection)
        : base(new DatabaseOptions<Database>() { ConnectionOptions = Connection }) {
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
       : base(new DatabaseOptions<Database>() { ConnectionOptions = Connection, DbContextOptions = Options }) {
    }

    /// <summary>
    /// 
    /// </summary>
    public Database()
        : base(new()) {
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
