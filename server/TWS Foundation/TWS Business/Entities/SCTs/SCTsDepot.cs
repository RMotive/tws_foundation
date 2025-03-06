using CSM_Foundation.Database.Entity;


namespace TWS_Business.Entities.SCTs;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="SCT"/> dataDatabases entity mirror.
/// </summary>
public class SCTsDepot
: BDepot<Database, SCT> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="SCT"/>.
    /// </summary>
    public SCTsDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public SCTsDepot()
        : base(new(), null) {

    }

}
