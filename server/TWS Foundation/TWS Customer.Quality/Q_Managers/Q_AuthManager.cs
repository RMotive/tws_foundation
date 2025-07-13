using System.Security.Claims;

using Microsoft.AspNetCore.Http;

using TWS_Customer.Managers.Auth;

namespace TWS_Customer.Quality.Q_Managers;

public class Q_AuthManager {

    readonly IAuthManager _manager;

    public Q_AuthManager() {

        HttpContext tracContext = new DefaultHttpContext {
            User = new ClaimsPrincipal(
                new ClaimsIdentity(
                    [
                        new Claim(ClaimTypes.Authentication, ""),
                    ],
                    ""
                )
            )
        };

        _manager = new AuthManager(
                new HttpContextAccessor {
                    HttpContext = tracContext
                }
            );
    }






    [Fact(DisplayName = $"Gets correctly the current SessionData by the transaction context")]
    public void Get() {
    }
}
