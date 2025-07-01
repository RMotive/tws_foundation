using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

namespace CSM_Foundation.Database.Entity.Depot.IDepot_Read;

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
    Task<BatchOperationOutput<TEntity>> Read(long[] ids);

    /// <summary>
    ///     Reads into the database for the <typeparamref name="TEntity"/> instances matched by the given <paramref name="input"/> parameters given.
    /// </summary>
    /// <param name="input">
    ///     Query input parameters.
    /// </param>
    Task<BatchOperationOutput<TEntity>> Read(QueryInput<TEntity, FilterQueryInput<TEntity>> input);
}
