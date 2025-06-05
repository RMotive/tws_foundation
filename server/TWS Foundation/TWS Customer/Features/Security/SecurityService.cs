using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Models.Output;

using CSM_Security.Depots;
using CSM_Security.Entities;

using Microsoft.AspNetCore.Http;

using TWS_Customer.Managers.Configuration;
using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Exceptions;
using TWS_Customer.Services.Records;

namespace TWS_Customer.Features.Security;

public interface ISecurityService {

    /// <summary>
    ///     Authenticates a given credentials subscribing the session into the current <see cref="AuthManager"/> context.
    /// </summary>
    /// <param name="input">
    ///     Authentication credentials.
    /// </param>
    /// <returns>
    ///     The <see cref="SessionData"/> information referencing the given <see cref="AuthInput"/> session.
    /// </returns>
    Task<SessionData> Authenticate(AuthInput input);
}

/// <summary>
///     [Service] implementation for [Security] operations.
/// </summary>
public class SecurityService
    : ISecurityService {

    /// <summary>
    ///     Current running environment configurations.
    /// </summary>
    readonly ConfigurationManager Configurations = ConfigurationManager.Manager;

    /// <summary>
    ///     Manager for session handling and context.
    /// </summary>
    readonly IAuthManager authManager;

    /// <summary>
    ///     [Depot] handler for <see cref="Account"/> entity.
    /// </summary>
    readonly IAccountsDepot AccountsDepot;

    readonly IHttpContextAccessor _contextAccesor;

    public SecurityService(
            IAccountsDepot accounts, 
            IAuthManager sessionManager, 
            IHttpContextAccessor contextAccesor
        ) {
        AccountsDepot = accounts;
        authManager = sessionManager;
        _contextAccesor = contextAccesor;
    }

    public async Task<SessionData> Authenticate(AuthInput input) {
        input.RequestContextAccessor = _contextAccesor;
        return await authManager.Auth(input);
    }

}
