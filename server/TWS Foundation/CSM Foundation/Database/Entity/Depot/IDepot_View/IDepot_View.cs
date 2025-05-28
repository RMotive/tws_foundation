using CSM_Foundation.Database.Entity.Models.Input;

namespace CSM_Foundation.Database.Entity.Depot.IDepot_View;
/// <summary>
///     Describes how a <see cref="IDepot_View{TMigrationSet}"/> implementation should
///     behave, providing {View} operations, a View operation is the creation of complex 
///     indexed, paged and handled TableViews based on the data.
/// </summary>
/// <typeparam name="T">
///     [Entity] type handling of the implementation.
/// </typeparam>
public interface IDepot_View<T>
    where T : class, IEntity {

    /// <summary>
    ///     Provides a table view of <see cref="T"/> calculated based on the given <paramref name="Options"/>.
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
    /// <param name="input"> 
    ///     Operation input parameters. 
    /// </param>
    /// <returns> 
    ///     The final View resolutions, giving metadata related to the created View and records resolved 
    /// </returns>
    Task<ViewOutput<T>> View(QueryInput<T, ViewInput<T>> input);
}
