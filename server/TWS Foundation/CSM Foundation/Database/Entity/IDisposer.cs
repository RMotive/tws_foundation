namespace CSM_Foundation.Database.Entity;

/// <summary>
///     [Interface] for Data Disposition managers.
/// </summary>
/// <remarks>
///     Data Disposition managers are used for custom and specific use-cases where operations add data to the context databases
///     that is not necessary needed to preserve, this managers stores and groups that data to be disposed by their each own database context.
/// </remarks>
public interface IDisposer {

    /// <summary>
    ///     Pushes the given <paramref name="entity"/> into the Data Disposition tracker.
    /// </summary>
    /// <param name="entity">
    ///     Instance to dispose.
    /// </param>
    void Push(IEntity entity);

    /// <summary>
    ///     Pushes the given <paramref name="entities"/> into the Data Disposition tracker.
    /// </summary>
    /// <param name="entities">
    ///     Instances to dispose.
    /// </param>
    void Push(IEntity[] entities);

    /// <summary>
    ///     Invokes the Data Disposition Stack to perform the Disposition operation, gathering the required database contexts and
    ///     removing tracked data.
    /// </summary>
    Task Dispose();
}
