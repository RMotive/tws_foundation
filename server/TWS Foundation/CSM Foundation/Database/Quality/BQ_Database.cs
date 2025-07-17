using CSM_Foundation.Core.Extensions;
using CSM_Foundation.Database.Utilitites;

using Microsoft.EntityFrameworkCore;

using Xunit;

namespace CSM_Foundation.Database.Quality;

/// <summary>
///     Base Quality for [MigrationDatabases].
///     
///     Define standard behaviors and quality checks for [MigrationDatabases] concept.
///     
///     [MigrationDatabases] concept: determines a dataDatabases class mirrored by an Entity Framework
///     migration implementation.
/// </summary>
/// <typeparam name="TDatabase">
///     Type of the [MigrationDatabases] implementation class.
/// </typeparam>
public abstract class BQ_Database<TDatabase>
    : IQ_Database
    where TDatabase : BDatabase_SQLServer<TDatabase> {

    /// <summary>
    ///     EF [MigrationDatabases].  
    /// </summary>
    protected readonly TDatabase Database;

    /// <summary>
    ///     Creates a new <see cref="BQ_Database{TDatabase}"/> instance.
    /// </summary>
    /// <param name="Sign">
    ///     Custom identifier for multiple database testing solutions.
    /// </param>
    public BQ_Database(string Sign = "DB") {
        
        Database = DatabaseUtilities.Q_Construct<TDatabase>(Sign);
    }

    [Fact]
    public void Migration() {
        IEnumerable<string> pendingMigrations = Database.Database.GetPendingMigrations();

        Assert.True(pendingMigrations.Empty(), $"Database instance isn't up-to-date with current database migrations. ({pendingMigrations.Count()} pendent)");
    }

    [Fact]
    public void Communication() {
        Assert.True(Database.Database.CanConnect(), $"{GetType()} cannot connect, check your connection credentials.");
    }

    [Fact]
    public void Evaluate() {
        Database.Evaluate();
    }
}
