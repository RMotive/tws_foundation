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
    ///     Provides a table view of <see cref="TSet"/> calculated based on the given <paramref name="Options"/>.
    ///     
    ///     Standard calculation mode:
    ///     
    ///     <para>
    ///         1. Filters: First are calculated filters that alters the available records to use. 
    ///     </para>    
    /// 
    ///     <para>
    ///         2. Page And Size: Second the page and size will be calculated from the total results.
    ///     </para>    
    /// 
    ///     <para> 
    ///         3. Orderings: Third the orderings will be applied after the records to be used are resolved.
    ///     </para>
    /// </summary>
    /// <param name="Options"> 
    ///     View calculation instructions, the View resolution behavior. 
    /// </param>
    /// <param name="Include"> 
    ///     Custom <see cref="TSet"/> special navigation properties inclusion 
    /// </param>
    /// <returns> 
    ///     The final View resolutions, giving metadata related to the created View and records resolved 
    /// </returns>
    Task<SetViewOut<TSet>> View(SetViewOptions<TSet> Options, Func<IQueryable<TSet>, IQueryable<TSet>>? Include = null);
}
