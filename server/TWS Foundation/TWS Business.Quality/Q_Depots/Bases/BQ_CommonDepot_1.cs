using CSM_Foundation.Database.Entity.Bases;
using CSM_Foundation.Database.Quality.Disposing;

using TWS_Business.Depots.Bases;

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
public abstract class BQ_CommonDepot<TCommon, TInternalEdge, TExternalEdge, TDepot>
    : BQ_CommonDepot<TCommon, TInternalEdge, TExternalEdge, TDepot, Database>
    where TCommon : class, ICommonEntity<TInternalEdge, TExternalEdge>, new()
    where TInternalEdge : class, ICommonScopeEntity<TCommon>
    where TExternalEdge : class, ICommonScopeEntity<TCommon>
    where TDepot : BCommonDepot<Database, TInternalEdge, TExternalEdge, TCommon> {

    /// <summary>
    ///     Creates a new <see cref="BQ_Business{TEntity, TDepot}"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Factory for the database context handler to be used.
    /// </param>
    /// <param name="Factories">
    ///     Collateral used databases factories to be used.
    /// </param>'

    protected BQ_CommonDepot(DatabaseFactory? Database = null, params DatabaseFactory[] Factories) : base("TWSB", Database, Factories) { }
}
