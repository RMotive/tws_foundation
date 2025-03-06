using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Insurances;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Insurance"/> dataDatabases entity mirror.
/// </summary>
public class InsurancesDepot : BDepot<Database, Insurance> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Insurance"/>.
    /// </summary>
    public InsurancesDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public InsurancesDepot() : base(new(), null) {
    }
}
