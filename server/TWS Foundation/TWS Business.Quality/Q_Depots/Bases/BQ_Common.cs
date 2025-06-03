using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Quality.Disposing;
using CSM_Foundation.Database.Quality;
using TWS_Business.Depots;

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
public abstract class BQ_Common<TCommon,TInternalEdge, TExternalEdge, TDepot>
    : BQ_CommonDepot<TCommon, TInternalEdge, TExternalEdge, TDepot, Database>
    where TCommon : CommonEntity<TInternalEdge, TExternalEdge>, new()
    where TInternalEdge : CommonEntityEdge<TCommon>
    where TExternalEdge : CommonEntityEdge<TCommon>
    where TDepot : BCommonDepot<TInternalEdge, TExternalEdge, TCommon> {

    /// <summary>
    ///     Creates a new <see cref="BQ_Business{TEntity, TDepot}"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Factory for the database context handler to be used.
    /// </param>
    /// <param name="Factories">
    ///     Collateral used databases factories to be used.
    /// </param>'

    protected BQ_Common(DatabaseFactory? Database = null, params DatabaseFactory[] Factories) : base("TWSB", Database, Factories) { }
}
