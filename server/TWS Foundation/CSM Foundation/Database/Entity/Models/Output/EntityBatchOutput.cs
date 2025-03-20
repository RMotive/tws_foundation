namespace CSM_Foundation.Database.Entity.Models.Output;

/// <summary>
///     [Record] that stores the information about a batch operation output result.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> affected by the operations.
/// </typeparam>
/// <typeparam name="TSuccess">
///     Type of the success result for the batch operation.
/// </typeparam>
public record EntityBatchOutput<TEntity, TSuccess>
    where TEntity : class, IEntity {

    /// <summary>
    ///     Collection of batch operation successes.
    /// </summary>
    public TSuccess[] Successes { get; init; }

    /// <summary>
    ///     Collection of batch operation failures. 
    /// </summary>
    public EntityOperationFailure<TEntity>[] Failures { get; init; }

    /// <summary>
    ///     Wheter at least one operation iteration has failed.
    /// </summary>
    public bool Failed { get; private set; }

    /// <summary>
    ///     Wheter all operations have failed.   
    /// </summary>
    public bool FullFailed { get; private set; }

    /// <summary>
    ///     The total amount of operations executed.
    /// </summary>
    public int OperationsCount { get; private set; }

    /// <summary>
    ///    The total amount of failed operations.
    /// </summary>
    public int FailuresCount { get; private set; }

    /// <summary>
    ///    The total amount of successful operations.
    /// </summary>
    public int SuccessesCount { get; private set; }

    public EntityBatchOutput(TSuccess[] Successes, EntityOperationFailure<TEntity>[] Failures) {
        this.Successes = Successes;
        this.Failures = Failures;

        SuccessesCount = this.Successes.Length;
        FailuresCount = this.Failures.Length;
        OperationsCount = SuccessesCount + FailuresCount;

        Failed = FailuresCount > 0;
        FullFailed = OperationsCount == FailuresCount;
    }
}