using CSM_Foundation.Database.Entity.Depot.IDepot_Read;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

namespace CSM_Foundation.Database.Entity.Depot;

/// <summary>
///     [Interface] describing [Delete] operations for [Depot] implementations.
/// </summary>
/// <typeparam name="TEntity">
///     [Entity] type for the [Depot] implementation.
/// </typeparam>
public interface IDepot_Delete<TEntity>
    where TEntity : class, IEntity {

    /// <summary>
    ///     Deletes the <see cref="TEntity"/> record based on its <see cref="IEntity.Id"/> value.
    /// </summary>
    /// <param name="Id">
    ///     <see cref="IEntity.Id"/> to match.
    /// </param>
    /// <returns>
    ///     Deleted <see cref="TEntity"/> record.
    /// </returns>
    public Task<TEntity> Delete(long Id);

    /// <summary>
    ///     Deletes a collection of <typeparamref name="TEntity"/> based on the given <paramref name="ids"/> collection.
    /// </summary>
    /// <param name="ids">
    ///     Collection of <see cref="IEntity.Id"/> to locate the <see cref="IEntity"/> collection to be removed.
    /// </param>
    /// <returns>
    ///     A batch operation result information object.
    /// </returns>
    public Task<BatchOperationOutput<TEntity>> Delete(long[] ids);

    /// <summary>
    ///     Deletes one or more items based on the given <see cref="BatchOperationInput{TEntity}.Filter"/> and <see cref="BatchOperationInput{TEntity}.Behavior"/> combination, gathering all the <see cref="IEntity"/>s objects 
    ///     matching the filter but only removing based on the given <see cref="BatchOperationInput{TEntity}.Behavior"/>
    /// </summary>
    /// <param name="input">
    ///     Operation parameters.
    /// </param>
    /// <returns>
    ///     A batch operation result informaiton object.
    /// </returns>
    public Task<BatchOperationOutput<TEntity>> Delete(QueryInput<TEntity, FilterQueryInput<TEntity>> input);
}
