using Microsoft.AspNetCore.Mvc.Filters;

namespace TWS_Customer.Managers.Auth;

/// <summary>
///     
/// </summary>
[AttributeUsage(AttributeTargets.Method)]
public class ActionAttribute
    : Attribute, IAuthorizationFilter {
    // private const string DISP_HEAD_KEY = "CSMDisposition";
    // private const string DISP_HEAD_VALUE = "Quality";
    const string AUTH_TOKEN_KEY = "CSMAuth";

    /// <summary>
    ///     Action that specifies the permit.
    /// </summary>
    readonly string Action;

    public ActionAttribute(string Action) {
        this.Action = Action;
    }

    public void OnAuthorization(AuthorizationFilterContext context) {
    }
}