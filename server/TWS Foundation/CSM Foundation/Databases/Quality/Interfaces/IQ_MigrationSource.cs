namespace CSM_Foundation.Databases.Quality.Interfaces;
/// <summary>
///     Interface Quality for [MigrationDatabases].
///     
///     Defines what quality operations must be performed by a [MigrationDatabases].
///     
///     [MigrationDatabases] concept: determines a dataDatabases class mirrored by an Entity Framework
///     migration implementation.
/// </summary>
public interface IQ_MigrationDatabases {
    /// <summary>
    ///     Qualify if the [MigrationDatabases] can communicate at runtime.
    /// </summary>
    public void Communication();
}
