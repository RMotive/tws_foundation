using CSM_Foundation.Product;

using TWS_Customer.Managers.Auth;
using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Records;

namespace TWS_Customer.Features.Security;

public interface ISecurityService
    : IService {

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
    ///     Manager for session handling and context.
    /// </summary>
    readonly IAuthManager _authManager;

    public SecurityService(
            IAuthManager sessionManager
        ) {
        _authManager = sessionManager;
    }

    public async Task<SessionData> Authenticate(AuthInput input) {
        return await _authManager.Auth(input);
    }

}
