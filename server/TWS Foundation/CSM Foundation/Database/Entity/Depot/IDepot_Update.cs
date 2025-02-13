using CSM_Foundation.Database.Models.Out;

namespace CSM_Foundation.Database.Entity.Depot;

/// <summary>
///     [Interface] describing [Update] actions for [Depot] implementations.
/// </summary>
/// <typeparam name="TEntity">
///     [Entity] type for the [Depot] implementation.
/// </typeparam>
public interface IDepot_Update<TEntity>
    where TEntity : IEntity {

    /// <summary>
    ///     Updates the given record calculating the current stored values with the given <paramref name="Record"/> to update and store the new values.
    /// </summary>
    /// <param name="Record">
    ///     [Entity] object values to store.
    /// </param>
    /// <returns></returns>
    /// <remarks>
    ///     Always the record to be overriden will be defined by the <see cref="IEntity.Id"/> property, if isn't given, will try with <see cref="IEntity_Name.Name"/> property in case the
    ///     [Entity] implementation does have it, otherwise will finally create a new record with the given values.
    /// </remarks>
    Task<RecordUpdateOut<TEntity>> Update(TEntity Record, AccumulateDelegate<TEntity>? Accumulate = null);
}
