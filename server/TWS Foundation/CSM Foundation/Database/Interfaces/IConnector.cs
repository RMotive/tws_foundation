namespace CSM_Foundation.Database.Interfaces;

/// <summary>
///     [Interface] for <see cref="IConnector"/> implementation.
///     
///     A Connector is a Many to Many data storage relation.
/// </summary>
/// <typeparam name="TSource"> 
///     Type of the source [Set] that holds the relation.
/// </typeparam>
/// <typeparam name="TTarget">
///     Type of the property related to the [TSet] relation.
/// </typeparam>
public interface IConnector<TSource, TTarget>
    : IConnector
    where TSource : class, ISet 
    where TTarget : class, ISet {

    /// <summary>
    ///     Source relation record.
    /// </summary>
    public TSource Source { get; set; }

    /// <summary>
    ///     Target relation record.
    /// </summary>
    public TTarget Target { get; set; }
}

/// <summary>
///     [Interface] for <see cref="IConnector"/> implementation.
///     
///     A Connector is a Many to Many data storage relation.
/// </summary>
public interface IConnector {
    /// <summary>
    ///     Source [Set] relation pointer.
    /// </summary>
    public int SourcePointer { get; set; }

    /// <summary>
    ///     Target [Set] relation pointer.
    /// </summary>
    public int TargetPointer { get; set; }
}