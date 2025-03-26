using System.Linq.Expressions;

using CSM_Foundation.Database.Entity.Models.Output;

namespace CSM_Foundation.Database.Entity.Depot;

/// <summary>
///     [Interface] to expose common [Read] action methods for <see cref="IDepot{TSet}"/> implementations.
/// </summary>
/// <typeparam name="TEntity">
///     [<see cref="IEntity"/>] implementation class type. This methods are based on this [Entity] to the params required and function returns.
/// </typeparam>
public interface IDepot_Read<TEntity>
    where TEntity : class, IEntity {

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
    Task<BatchOperationOutput<TEntity, TEntity>> Read(long[] ids);

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
    Task<BatchOperationOutput<TEntity, TEntity>> Read(EntityBatchBehaviors behavior, Expression<Func<TEntity, bool>> filter, QueryProcessor<TEntity>? postProcessing = null);
}
