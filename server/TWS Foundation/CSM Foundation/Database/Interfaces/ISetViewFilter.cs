namespace CSM_Foundation.Database.Interfaces;

/// <summary>
/// 
/// </summary>
public interface ISetViewFilter<TSet>
    : ISetViewFilterNode<TSet>
    where TSet : ISet {
    /// <summary>
    /// 
    /// </summary>
    string Property { get; set; }
}

/// <summary>
/// 
/// </summary>
public static class ISetArrayExtension {

    /// <summary>
    ///     Sorts the <see cref="ISetViewFilter{TSet}"/> array based on its orders.
    ///     
    ///     <para>
    ///         This operation is mutable that means alters the current array where the <see langword="method"/> where invoked
    ///     </para>
    /// </summary>
    public static void Sort<TSet>(this ISetViewFilter<TSet>[] Records) 
        where TSet : ISet {

        ISetViewFilter<TSet>[] sorted = [..Records.OrderBy(i => i.Order)];

        Records = sorted;
    }
}