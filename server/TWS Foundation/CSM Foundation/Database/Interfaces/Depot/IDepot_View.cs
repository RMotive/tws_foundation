using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

namespace CSM_Foundation.Database.Interfaces.Depot;
/// <summary>
///     Describes how a <see cref="IDepot_View{TMigrationSet}"/> implementation should
///     behave, providing {View} operations, a View operation is the creation of complex 
///     indexed, paged and handled TableViews based on the data.
/// </summary>
/// <typeparam name="TSet">
///     The dataDatabases object that the implementation handles.
/// </typeparam>
public interface IDepot_View<TSet>
    where TSet : ISet {
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <param name="Include"></param>
    /// <returns></returns>
    Task<SetViewOut<TSet>> View(SetViewOptions<TSet> Options, Func<IQueryable<TSet>, IQueryable<TSet>>? Include = null);
}
