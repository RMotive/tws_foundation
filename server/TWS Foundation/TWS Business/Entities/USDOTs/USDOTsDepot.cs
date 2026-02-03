using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

namespace TWS_Business.Entities.USDOTs;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="USDOT"/> dataDatabases entity mirror.
/// </summary>
public class USDOTsDepot : DepotBase<Database, USDOT> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="USDOT"/>.
    /// </summary>
    public USDOTsDepot(Database Databases, IDisposer<IEntity>? Disposer = null)
       : base(Databases, Disposer) {
    }
    public USDOTsDepot() : base(new(), null) {
    }
}
