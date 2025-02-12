using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Quality.Interfaces;

using Xunit;

namespace CSM_Foundation.Database.Quality.Bases;

/// <summary>
///     Base Quality for [MigrationDatabases].
///     
///     Define standard behaviors and quality checks for [MigrationDatabases] concept.
///     
///     [MigrationDatabases] concept: determines a dataDatabases class mirrored by an Entity Framework
///     migration implementation.
/// </summary>
/// <typeparam name="TDatabases">
///     Type of the [MigrationDatabases] implementation class.
/// </typeparam>
public abstract class BQ_MigrationDatabases<TDatabases>
    : IQ_MigrationDatabases
    where TDatabases : BDatabase_SQLServer<TDatabases> {
    /// <summary>
    ///     EF [MigrationDatabases]. 
    /// </summary>
    protected readonly TDatabases Databases;

    /// <summary>
    ///     Generates a new base quality class for [MigrationDatabases].
    /// </summary>
    /// <param name="Databases"></param>
    public BQ_MigrationDatabases(TDatabases Databases) {
        this.Databases = Databases;
    }

    [Fact]
    public void Communication() {
        Assert.True(Databases.Database.CanConnect(), $"{GetType()} cannot connect, check your connection credentials");
    }

    [Fact]
    public void Evaluate() {
        Databases.Evaluate();
    }
}
