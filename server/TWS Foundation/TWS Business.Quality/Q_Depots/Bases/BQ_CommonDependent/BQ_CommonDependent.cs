using CSM_Database_Core.Depots.Abstractions.Bases;

using CSM_Database_Testing.Disposing.Abstractions.Bases;

using CSM_Foundation.Database.Quality;

using TWS_Business.Bases;

namespace TWS_Business.Quality.Q_Depots.Bases;

/// <summary>
///     [Abstract] for [Quality] implementations for [Business] database [Depots].
/// </summary>
/// <typeparam name="TEntity">
///     Type of the entity based on test.
/// </typeparam>
/// <typeparam name="TDepot">
///     Type of the depot based on test.    
/// </typeparam>
public abstract class BQ_CommonDependence<TCommonDependence, TDepot>
    : BQ_CommonDependenceDepot<TDepot, Database, TCommonDependence>
    where TCommonDependence : BEntity, new()
    where TDepot : DepotBase<Database, TCommonDependence> {

    /// <summary>
    ///     Creates a new <see cref="BQ_Business{TEntity, TDepot}"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Factory for the database context handler to be used.
    /// </param>
    /// <param name="Factories">
    ///     Collateral used databases factories to be used.
    /// </param>'

    protected BQ_CommonDependence(DatabaseFactory? Database = null, params DatabaseFactory[] Factories) : base("TWSB", Database, Factories) { }
}
