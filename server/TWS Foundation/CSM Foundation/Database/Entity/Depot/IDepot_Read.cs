using System.Linq.Expressions;

using CSM_Foundation.Database.Models.Out;

namespace CSM_Foundation.Database.Entity.Depot;

/// <summary>
///     Indicates how [Read] operations must behave about how to calculate the result.
/// </summary>
public enum ReadBehaviors {
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
///     [Interface] to expose common [Read] action methods for <see cref="IDepot{TSet}"/> implementations.
/// </summary>
/// <typeparam name="TEntity">
///     [<see cref="IEntity"/>] implementation class type. This methods are based on this [Entity] to the params required and function returns.
/// </typeparam>
public interface IDepot_Read<TEntity>
    where TEntity : IEntity {

    /// <summary>
    ///     Reads into the <see cref="TEntity"/> database [Set] for matched records.
    /// </summary>
    /// <param name="Behavior">
    ///     How the function will behave about the result.
    /// </param>
    /// <param name="Filter">
    ///     How the function will pick the correct records to take.
    /// </param>
    /// <param name="Accumulate">
    ///     Proxied [Query] to generate accumulative instructions.
    /// </param>
    /// <returns>
    ///     Function result.
    /// </returns>
    public Task<SetBatchOut<TEntity>> Read(ReadBehaviors Behavior, Expression<Func<TEntity, bool>> Filter, AccumulateDelegate<TEntity>? Accumulate = null);
}
