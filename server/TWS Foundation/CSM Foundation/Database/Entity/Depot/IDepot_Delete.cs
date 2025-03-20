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
    ///     Deletes the given <paramref name="Records"/>.
    /// </summary>
    /// <param name="Records">
    ///     [Entity] database set records to remove.
    /// </param>
    /// <returns>
    ///     A result for [Batch] record handling operations.
    /// </returns>
    /// <remarks>
    ///     The way to find the [<paramref name="Records"/>] to delete follows the next order:
    ///     <para>
    ///         <list type="number">
    ///             <item> <see cref="IEntity.Id"/> In case its value is bigger than 0 </item>
    ///             <item> <see cref="IEntity_Name.Name"/> In case the <see cref="TEntity"/> inherits from <see cref="IEntity_Name"/> and the property value is not null nor empty string. </item>
    ///         </list>
    ///     </para>
    /// </remarks>
    public Task<EntityBatchOutput<TEntity, TEntity>> Delete(TEntity[] Records);

    /// <summary>
    ///     Deletes the given <paramref name="Record"/>.
    /// </summary>
    /// <param name="Record">
    ///     [Entity] database set record to remove.
    /// </param>
    /// <returns>
    ///     Deleted <see cref="TEntity"/> record.
    /// </returns>
    /// <remarks>
    ///     The way to find the [<paramref name="Record"/>] to delete follows the next order:
    ///     <para>
    ///         <list type="number">
    ///             <item> <see cref="IEntity.Id"/> In case its value is bigger than 0 </item>
    ///             <item> <see cref="IEntity_Name.Name"/> In case the <see cref="TEntity"/> inherits from <see cref="IEntity_Name"/> and the property value is not null nor empty string. </item>
    ///         </list>
    ///     </para>
    /// </remarks>
    public Task<TEntity> Delete(TEntity Record);

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
}
