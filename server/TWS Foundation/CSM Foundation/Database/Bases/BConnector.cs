using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Bases;

/// <summary>
///     [Abstract] class to handle default behaviors for <see cref="BConnector{TSource, TTarget}"/> implementations.
/// </summary>
/// <typeparam name="TSource"> 
///     Type of the source [Set] that holds the relation.
/// </typeparam>
/// <typeparam name="TTarget">
///     Type of the property related to the [TSet] relation.
/// </typeparam>
public abstract partial class BConnector<TSource, TTarget>
    : IConnector<TSource, TTarget>
    where TSource : class, ISet
    where TTarget : class, ISet {

    public int SourcePointer { get; set; }
    public virtual TSource Source { get; set; } = default!;

    public int TargetPointer { get; set; }
    public virtual TTarget Target { get; set; } = default!;
}