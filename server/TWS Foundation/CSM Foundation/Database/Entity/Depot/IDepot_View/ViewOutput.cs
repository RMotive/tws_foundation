namespace CSM_Foundation.Database.Entity.Depot.IDepot_View;

/// <summary>
///     {model} class for <see cref="ViewOutput{TEntity}"/>.
///     
///     <para>
///         Defines a data model class that represents an {output} object from the <see cref="IDepot_View{TEntity}.View(Models.Input.OperationInput{TEntity, ViewInput{TEntity}})"/> operation along different
///         <see cref="IEntity"/> implementations.
///     </para>
/// </summary>
/// <typeparam name="TEntity">
///     type of the <see cref="IEntity"/> implementation the <see cref="IDepot_View{TEntity}.View(Models.Input.OperationInput{TEntity, ViewInput{TEntity}})"/> was called for.
/// </typeparam>
public class ViewOutput<TEntity>
    where TEntity : IEntity {

    TEntity[] _Records = [];
    /// <summary>
    ///     The collection of items gathered.
    /// </summary>
    public required TEntity[] Entities {
        get => _Records;
        init {
            _Records = value;
            Length = value.Length;
        }
    }
    /// <summary>
    ///     The available pages.
    /// </summary>
    public required int Pages { get; init; }

    /// <summary>
    ///     The current page.
    /// </summary>
    public required int Page { get; init; }

    /// <summary>
    ///     Indicates the timemark when was created.
    /// </summary>
    public DateTime Timestamp { get; init; } = DateTime.UtcNow;

    /// <summary>
    ///     Indicates the quantity of records that this result contains.
    /// </summary>
    public int Length { get; init; }

    /// <summary>
    ///     Count of total records that currently exist at the live database
    /// </summary>
    public required int Count { get; init; }
}
