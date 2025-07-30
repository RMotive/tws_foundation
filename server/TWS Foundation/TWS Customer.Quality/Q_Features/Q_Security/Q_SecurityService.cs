using CSM_Security;

using Microsoft.AspNetCore.Http;

using TWS_Customer.Features.Security;
using TWS_Customer.Managers.Auth;

namespace TWS_Customer.Quality.Q_Features.Q_Security;

/// <summary>
///     
/// </summary>
public class Q_SecurityService
    : BQ_Service<ISecurityService> {

    protected override ISecurityService ServiceFactory() {
        Database securityDb = BuildSecurityDb();

        IHttpContextAccessor contextAccesor = new HttpContextAccessor();

        return new SecurityService(
                new AuthManager(
                        contextAccesor
                    )
            );
    }


}
