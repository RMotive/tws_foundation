using CSM_Foundation.Database.Entity;

namespace CSM_Foundation.Database.Connector;

/// <summary>
///     [Interface] for <see cref="IConnector"/> implementation.
///     
///     A Connector is a Many to Many data storage relation.
/// </summary>
/// <typeparam name="TSource"> 
///     Type of the source [Set] that holds the relation.
/// </typeparam>
/// <typeparam name="TTarget">
///     Type of the property related to the [SourceT] relation.
/// </typeparam>
public interface IConnector<TSource, TTarget>
    : IConnector
    where TSource : class, IEntity 
    where TTarget : class, IEntity {

    /// <summary>
    ///     SourceT relation record.
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
    ///     SourceT [Set] relation pointer.
    /// </summary>
    public int SourcePointer { get; set; }

    /// <summary>
    ///     Target [Set] relation pointer.
    /// </summary>
    public int TargetPointer { get; set; }
}