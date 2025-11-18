using CSM_Security.Depots;
using CSM_Security.Entities;
using CSM_Security.Quality.Utils;

using TWS_Customer.Features.Security;

namespace TWS_Customer.Quality.Q_Features.Q_Security;

/// <summary>
///     Quality tests class for <see cref="AccountsService"/> implementation.
/// </summary>
public class Q_PermitsService
    : BQ_Service<IPermitsService, Permit> {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    public Q_PermitsService() { }


    protected override Permit DraftEntity(string entropy)
    => DraftUtils.Permit();

    protected override PermitsService ServiceFactory() {
        CSM_Security.Database securityDatabase = BuildSecurityDb();

        IPermitsDepot permitsDepot = new PermitsDepot(securityDatabase, Disposer);

        return new PermitsService(permitsDepot);
    }
}
