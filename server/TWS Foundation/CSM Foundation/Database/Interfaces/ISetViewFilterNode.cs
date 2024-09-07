using System.Linq.Expressions;

namespace CSM_Foundation.Database.Interfaces;

/// <summary>
/// 
/// </summary>
public interface ISetViewFilterNode<TSet>
    where TSet : ISet {
    /// <summary>
    /// 
    /// </summary>
    int Order { get; set; }

    /// <summary>
    /// 
    /// </summary>
    string Discrimination { get; }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Set"></param>
    /// <returns></returns>
    Expression<Func<TSet, bool>> Compose();
}
