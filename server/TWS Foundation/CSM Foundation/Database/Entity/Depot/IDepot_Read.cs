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
    ///     Reads into the database for the <typeparamref name="TEntity"/> instance with the given <paramref name="id"/>.
    /// </summary>
    /// <param name="id">
    ///     Identifier of the desired <typeparamref name="TEntity"/>.
    /// </param>
    /// <returns> <see cref="TEntity"/> instance found. </returns>
    Task<TEntity> Read(long id);

    /// <summary>
    ///     Reads into the database for a collection of <typeparamref name="TEntity"/> with the given <paramref name="ids"/>.
    /// </summary>
    /// <param name="ids">
    ///     <see cref="IEntity.Id"/> pointer to match with the database entities.
    /// </param>
    /// <returns>
    ///     An <see cref="IEntity"/> batch operation result.
    /// </returns>
    Task<EntityBatchOut<TEntity>> Read(long[] ids);

    /// <summary>
    ///     Reads into the database for the <typeparamref name="TEntity"/> instances matched by the given <paramref name="filter"/>.
    /// </summary>
    /// <param name="behavior">
    ///     How the function will behave about the result.
    /// </param>
    /// <param name="filter">
    ///     How the function will pick the correct records to take.
    /// </param>
    /// <param name="postProcessing">
    ///     Post processing function to catch the native operation resulted query and modify for custom needs.
    /// </param>
    /// <returns>
    ///     Collection of <typeparamref name="TEntity"/> instances found.
    /// </returns>
    Task<EntityBatchOut<TEntity>> Read(ReadBehaviors behavior, Expression<Func<TEntity, bool>> filter, AccumulateDelegate<TEntity>? postProcessing = null);
}
