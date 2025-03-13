using System.Text.Json;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Models;

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
    : IQ_MigrationDatabases
    where TDatabase : BDatabase_SQLServer<TDatabase> {

    const string CNNT = "Q_{0}.Connection";

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
        string connectionVariable = string.Format(CNNT, Sign);

        string connectionPath = Environment.GetEnvironmentVariable(connectionVariable)
            ?? throw new Exception($"Unable to run tests for {typeof(TDatabase).FullName}, due to couldn't be found Connection file path (Make sure the environment variable [{connectionVariable}] is set or configured at the .runsettings tests context)");

        using FileStream fileReader = new(connectionPath, FileMode.Open, FileAccess.Read);

        ConnectionOptions connection = JsonSerializer.Deserialize<ConnectionOptions>(fileReader)
            ?? throw new Exception($"File ({connectionPath}) doesn't contain the correct format for (ConnectionOptions)");

        Database = (TDatabase?)Activator.CreateInstance(typeof(TDatabase), connection)
            ?? throw new Exception($"Unable to create ({typeof(TDatabase).FullName}) instance with the ConnectionOptions[{connectionPath}]");
    }

    [Fact]
    public void Communication() {
        Assert.True(Database.Database.CanConnect(), $"{GetType()} cannot connect, check your connection credentials");
    }

    [Fact]
    public void Evaluate() {
        Database.Evaluate();
    }
}
