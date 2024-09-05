using System.Linq.Expressions;

namespace CSM_Foundation.Database.Interfaces;

/// <summary>
/// 
/// </summary>
public interface ISetViewFilter<TSet>
    where TSet : ISet {
    /// <summary>
    /// 
    /// </summary>
    int Order { get; set; }

    /// <summary>
    /// 
    /// </summary>
    string Property {  get; set; }


    /// <summary>
    /// 
    /// </summary>
    /// <param name="Set"></param>
    /// <returns></returns>
    Expression<Func<TSet, bool>> Compose();
}
