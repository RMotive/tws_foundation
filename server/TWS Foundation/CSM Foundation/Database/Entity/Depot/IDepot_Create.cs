using CSM_Foundation.Database.Entity.Models.Output;

namespace CSM_Foundation.Database.Entity.Depot;
/// <summary>
///     Describes the behavior for a <see cref="IDepot_Create{TMigrationSet}"/>,
///     this means is able to handle a <see cref="TEntity"/> live migration entity mirror between
///     standard creation transactions.
/// </summary>
/// <typeparam name="TEntity">
///     [Entity] type of the [Depot] implementation.
/// </typeparam>
public interface IDepot_Create<TEntity>
    where TEntity : class, IEntity {
    /// <summary>
    ///     Creates a single <paramref name="Record"/> record into the live migration.
    ///     <br>
    ///         <list type="bullet">
    ///         <listheader> NOTES: </listheader>
    ///         <item> Validates if the <paramref name="Record"/> has unique properties and validates if they already exists. </item>
    ///         <item> The <see cref="TEntity.Id"/> property is always auto-generated. </item>
    ///         <item> Can auto-generate properties dependengin on the object behavior. </item>
    ///         </list>
    ///     </br>
    /// </summary>
    /// <param name="Record">
    ///     <paramref name="Record"/> to store.
    /// </param>
    /// <returns> 
    ///     The successfully stored object
    /// </returns>
    Task<TEntity> Create(TEntity Record);

    /// <summary>
    ///     Creates a collection of <paramref name="Records"/> records into the live migration.
    /// </summary>
    /// <param name="Records">
    ///     <paramref name="Records"/> to store.
    /// </param>
    /// <param name="Sync">
    ///     If the transaction should finish at the first failure found.
    ///     throwing instantly an exception not returning the result.
    /// </param>
    /// <returns>
    ///     The operation result information.
    /// </returns>
    Task<BatchOperationOutput<TEntity, TEntity>> Create(ICollection<TEntity> Records, bool Sync = false);
}
