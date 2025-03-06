using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.USDOTs;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="USDOT"/> dataDatabases entity mirror.
/// </summary>
public class USDOTsDepot : BDepot<BusinessDatabase, USDOT> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="USDOT"/>.
    /// </summary>
    public USDOTsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public USDOTsDepot() : base(new(), null) {
    }
}
 