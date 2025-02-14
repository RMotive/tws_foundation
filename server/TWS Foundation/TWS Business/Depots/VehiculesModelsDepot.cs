using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="VehiculeModel"/> dataDatabases entity mirror.
/// </summary>
public class VehiculesModelsDepot : BDepot<BusinessDatabase, VehiculeModel> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="VehiculeModel"/>.
    /// </summary>
    public VehiculesModelsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public VehiculesModelsDepot() : base(new(), null) {
    }
}
