using CSM_Foundation.Database.Interfaces.Depot;

namespace CSM_Foundation.Database.Interfaces;
/// <summary>
///     Determines how a complex <see cref="IDepot{TMigrationSet}"/> 
///     implementation should behave.
///     
///     <br>
///         A <see cref="IDepot{TMigrationSet}"/> is considered as a
///         data repository for a specific <typeparamref name="TSet"/>.
///         providing data, storing data, updating data, etc...
///     </br>
/// </summary>
/// <typeparam name="TSet">
///     The dataDatabases object that the implementation handles.
/// </typeparam>
public interface IDepot<TSet>
    : IDepot_View<TSet>
    , IDepot_Read<TSet>
    , IDepot_Create<TSet>
    , IDepot_Update<TSet>
    , IDepot_Delete<TSet>
    where TSet : ISet { }
