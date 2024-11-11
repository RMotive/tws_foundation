
using CSM_Foundation.Server.Exceptions;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

using TWS_Customer.Managers;

namespace TWS_Foundation.Authentication;

[AttributeUsage(AttributeTargets.Method)]
public class AuthAttribute
    : TypeFilterAttribute {
    public AuthAttribute(string Feature, string Action)
        : base(typeof(AuthFilter)) {

        Arguments = [Feature, Action];
    }
}

public class AuthFilter
    : IAuthorizationFilter {
    private const string DISP_HEAD_KEY = "CSMDisposition";
    private const string DISP_HEAD_VALUE = "Quality";
    private const string AUTH_TOKEN_KEY = "CSMAuth";

    private readonly SessionManager SessionManager;

    private readonly string Feature;
    private readonly string Action;

    public AuthFilter(string Feature, string Action, SessionManager SessionManager) {
        this.Feature = Feature;
        this.Action = Action;
        this.SessionManager = SessionManager;
    }

    public void OnAuthorization(AuthorizationFilterContext context) {
        IHeaderDictionary headers = context.HttpContext.Request.Headers;

        string authHedaer = headers.Authorization
            .Where(i => i is not null && i.Contains(AUTH_TOKEN_KEY))
            .FirstOrDefault()
            ?? throw new XAuth(XAuthSituation.Lack);

        string[] authToken = authHedaer.Split(' ')[1].Split('@');

        string token = authToken[0];
        string sign = authToken[1];
    }
}
