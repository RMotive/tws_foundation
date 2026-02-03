using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Database_Testing.Abstractions.Bases;
using CSM_Database_Testing.Disposing.Abstractions.Bases;

namespace CSM_Security.Quality.Q_Depots;

/// <summary>
///     [Abstract] for [Quality] implementations for [Security] database [Depots].
/// </summary>
/// <typeparam name="TEntity">
///     Type of the entity based on test.
/// </typeparam>
/// <typeparam name="TDepot">
///     Type of the depot based on test.    
/// </typeparam>
public abstract class BQ_Security<TEntity, TDepot>
    : TestingDepotBase<TEntity, TDepot, Database>
    where TEntity : class, IEntity, new()
    where TDepot : class, IDepot<TEntity> {

    /// <summary>
    ///     Creates a new <see cref="BQ_Security{TEntity, TDepot}"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Factory for the database context handler to be used.
    /// </param>
    /// <param name="Factories">
    ///     Collateral used databases factories to be used.
    /// </param>
    protected BQ_Security(DatabaseFactory? Database = null, params DatabaseFactory[] Factories) : base(Database, Factories) { }
}
