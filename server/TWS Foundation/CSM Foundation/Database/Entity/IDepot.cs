using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity.Depot;

namespace CSM_Foundation.Database.Entity;

/// <summary>
///     Indicates how operations that handles a batch of <see cref="IEntity"/> will interact.
/// </summary>
public enum EntityBatchBehaviors {
    /// <summary>
    ///     First record found that matches.
    /// </summary>
    First,
    /// <summary>
    ///     Last record found that matches.
    /// </summary>
    Last,
    /// <summary>
    ///     All records found that match.
    /// </summary>
    All,
}

/// <summary>
///     [Delegate] declaration to expose an easier API to generate the accumulative instructions for the query after filtering.
/// </summary>
/// <typeparam name="TEntity">
///     [<see cref="IEntity"/>] implementation class type.
/// </typeparam>
/// <param name="query">
///     The proxied query to apply accumulative instructions.
/// </param>
/// <returns>
///     Must return the accumulated query as <see cref="IQueryable{T}"/> object is immutable.
/// </returns>
public delegate IQueryable<TEntity> QueryProcessor<TEntity>(IQueryable<TEntity> query) where TEntity : IEntity;

/// <summary>
///     Determines how a complex <see cref="IDepot{TEntity}"/> 
///     implementation should behave.
///     
///     <br>
///         A <see cref="IDepot{TEntity}"/> is considered as a
///         data repository for a specific <typeparamref name="TEntity"/>.
///         providing data, storing data, updating data, etc...
///     </br>
/// </summary>
/// <typeparam name="TEntity">
///     [Entity] type for the <see cref="IDepot{TEntity}"/> handling implementation.
/// </typeparam>
public interface IDepot<TEntity>
    : IDepot_View<TEntity>
    , IDepot_Read<TEntity>
    , IDepot_Create<TEntity>
    , IDepot_Update<TEntity>
    , IDepot_Delete<TEntity>
    where TEntity : class, IEntity { }
