using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Server.Exceptions;

using CSM_Security.Depots;
using CSM_Security.Entities;

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Filters;

using TWS_Customer.Managers.Session;

namespace TWS_Foundation.Authentication;

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