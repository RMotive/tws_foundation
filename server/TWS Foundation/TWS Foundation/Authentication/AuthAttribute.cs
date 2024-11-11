
using CSM_Foundation.Server.Exceptions;

using Microsoft.AspNetCore.Mvc.Filters;

using TWS_Customer.Managers;

namespace TWS_Foundation.Authentication;


[AttributeUsage(AttributeTargets.Method)]
public class AuthAttribute
    : Attribute, IAuthorizationFilter {
    private const string DISP_HEAD_KEY = "CSMDisposition";
    private const string DISP_HEAD_VALUE = "Quality";
    private const string AUTH_TOKEN_KEY = "CSMAuth";

    private readonly string Feature;
    private readonly string Action;

    public AuthAttribute(string Feature, string Action) {
        this.Feature = Feature;
        this.Action = Action;
    }

    public void OnAuthorization(AuthorizationFilterContext context) {
        SessionManager sessionManager = context.HttpContext.RequestServices.GetRequiredService<SessionManager>();
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