using CSM_Foundation.Server.Exceptions;

using Microsoft.AspNetCore.Mvc.Filters;

using TWS_Customer.Managers.Session;

using TWS_Security.Depots.Accounts;
using TWS_Security.Depots.Solutions;
using TWS_Security.Sets;

namespace TWS_Foundation.Authentication;

/// <summary>
///     
/// </summary>
[AttributeUsage(AttributeTargets.Method)]
public class AuthAttribute
    : Attribute, IAsyncAuthorizationFilter {
    // private const string DISP_HEAD_KEY = "CSMDisposition";
    // private const string DISP_HEAD_VALUE = "Quality";
    private const string AUTH_TOKEN_KEY = "CSMAuth";

    /// <summary>
    ///     Action that specifies the permit.
    /// </summary>
    readonly string Action;

    public AuthAttribute(string Action) {
        this.Action = Action;
    }

    public async Task OnAuthorizationAsync(AuthorizationFilterContext context) {
        HttpContext callContext = context.HttpContext;
        IServiceProvider serProvider = callContext.RequestServices;

        IHeaderDictionary headers = callContext.Request.Headers;

        string authHedaer = headers.Authorization
            .Where(i => i is not null && i.Contains(AUTH_TOKEN_KEY))
            .FirstOrDefault()
            ?? throw new XAuth(XAuthSituation.Lack);

        string[] authToken = authHedaer.Split(' ')[1].Split('@');

        string token = authToken[0];
        string sign = authToken[1];

        SessionManager sessionManager = serProvider.GetRequiredService<SessionManager>();
        IAccountsDepot accounts = serProvider.GetRequiredService<IAccountsDepot>();
        ISolutionsDepot solutions = serProvider.GetRequiredService<ISolutionsDepot>();

        Session session = await sessionManager.Get(Guid.Parse(token), accounts, true)
            ?? throw new XAuth(XAuthSituation.Expired);

        if (session.Wildcard) {
            return;
        }

        Solution runningSolution = (await solutions.Read(
                (solution) => solution.Sign == sign,
                CSM_Foundation.Database.Enumerators.SetReadBehaviors.First
            )).Successes[0];

        Permit[] permits = session.Permits;
        Permit targetPermit = permits.Where(i => i.Solution == runningSolution.Id).FirstOrDefault()
            ?? throw new XAuth(XAuthSituation.Unauthorized);

        if (!targetPermit.Enabled) {
            throw new XAuth(XAuthSituation.Unauthorized);
        }

        Action.ToString();
    }
}