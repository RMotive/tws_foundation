using System.Text.Json.Serialization;

namespace CSM_Foundation.Database.Entity.Models;


/// <summary>
///     [Record] that stores the information about a failed operation over an <see cref="IEntity"/>.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> that failed.
/// </typeparam>
public record EntityOperationFailure<TEntity>
    where TEntity : IEntity {

    /// <summary>
    ///     Original instance that the operation was committed and failed.
    /// </summary>
    public TEntity Entity { get; init; } = default!;

    /// <summary>
    ///     Message caugth from the immediate exception that caused the operation failure.
    /// </summary>
    public string Message { get; init; } = string.Empty;

    /// <summary>
    ///     <see cref="System.Exception"/> caught over the operation failure, the information to trace
    ///     all about the operation failure at system level.
    /// </summary>
    [JsonIgnore]
    public Exception Exception { get; init; } = default!;

    /// <summary>
    ///     Creates a new <see cref="EntityOperationFailure{TEntity}"/> instance.
    /// </summary>
    /// <param name="entity">
    ///     <typeparamref name="TEntity"/> instance targeted by the operation that failed.
    /// </param>
    /// <param name="exception">
    ///     <see cref="System.Exception"/> caught over the operation failure.
    /// </param>
    public EntityOperationFailure(TEntity entity, Exception exception) {
        Entity = entity;
        Exception = exception;
        Message = exception.Message;
    }
}