using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Quality.Disposing;
using CSM_Foundation.Database.Quality;

namespace TWS_Business.Quality.Q_Depots;

/// <summary>
///     [Abstract] for [Quality] implementations for [Business] database [Depots].
/// </summary>
/// <typeparam name="TEntity">
///     Type of the entity based on test.
/// </typeparam>
/// <typeparam name="TDepot">
///     Type of the depot based on test.    
/// </typeparam>
public abstract class BQ_Business<TEntity, TDepot>
    : BQ_Depot<TEntity, TDepot, Database>
    where TEntity : BEntity, new()
    where TDepot : class, IDepot<TEntity> {

    /// <summary>
    ///     Creates a new <see cref="BQ_Business{TEntity, TDepot}"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Factory for the database context handler to be used.
    /// </param>
    /// <param name="Factories">
    ///     Collateral used databases factories to be used.
    /// </param>
    protected BQ_Business(DatabaseFactory? Database = null, params DatabaseFactory[] Factories) : base("TWSB", Database, Factories) { }
}
