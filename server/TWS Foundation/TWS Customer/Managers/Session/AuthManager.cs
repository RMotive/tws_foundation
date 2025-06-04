using System.Collections.Concurrent;
using System.Linq.Expressions;

using CSM_Foundation.Database.Entity.Depot.IDepot_Read;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Server.Exceptions;

using CSM_Security.Depots;
using CSM_Security.Entities;

using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

using TWS_Customer.Features;
using TWS_Customer.Features.Security;
using TWS_Customer.Services.Exceptions;
using TWS_Customer.Services.Records;

using SessionsBag = System.Collections.Concurrent.ConcurrentDictionary<System.Guid, (TWS_Customer.Services.Records.AuthInput Credentials, System.DateTime Expiration)>;
using SessionScope = (TWS_Customer.Services.Records.AuthInput authInput, System.DateTime expiration);

namespace TWS_Customer.Managers.Session;

/// <summary>
///     {interface} definition for a {Session} scope {Manager}, responsible to handle and manage storing and calculations about the
///     current server runtime sessions authenticated and identification of them.
/// </summary>
/// <remarks>
///     <b> 
///         Warning: custom implementations must consider asynchronous access for dictionaries and another batch data structures,
///     </b> 
/// </remarks>
public interface IAuthManager {

    /// <summary>
    ///     
    /// </summary>
    /// <param name="authInput"></param>
    /// <param name="feature"></param>
    /// <param name="action"></param>
    /// <returns></returns>
    public Task<SessionData> Auth(AuthInput authInput);
}

/// <summary>
///     {Manager} implementation that handles all the sessions currently operating in all TWS solutions environment.
/// </summary>
public sealed class AuthManager
    : IAuthManager {

    /// <summary>
    /// 
    /// </summary>
    const string AUTH_TOKEN_KEY = "CSMAuth";


    /// <summary>
    ///     Expiration time aggregation for token refreshing, this value is aggregated to the current expirations to get a final expiration timestamp.
    /// </summary>
    readonly TimeSpan EXPIRE_THRESHOLD = TimeSpan.FromHours(6);

    /// <summary>
    ///     Stores all the current <see cref="AuthManager"/> stored sessions keyed by the calculated unique token.
    /// </summary>
    readonly SessionsBag _sessionsBag = [];

    /// <summary>
    ///     Stores all the current calculated unique tokens managed, used to validate token related relations with no need to access <see cref="_sessionsBag"/> dictionary.
    /// </summary>
    readonly ConcurrentBag<Guid> _tokensBag = [];


    /// <summary>
    ///     Tries to get a <see cref="SessionData"/> stored in the context based on the given <paramref name="Token"/>
    /// </summary>
    /// <param name="Token">
    ///     Token to identify the session context.
    /// </param>
    /// <param name="Accounts">
    ///     Depot dependency to track and get most recent needed data.
    /// </param>
    /// <param name="Refresh">
    ///     Indicates if the session was found, refresh its expiration time.
    /// </param>
    /// <returns>
    ///     <see langword="null"/>: The session wasn't found.
    ///     <para> <see cref="SessionData"/>: when it got found. </para>
    /// </returns>
    /// <remarks>
    ///     <paramref name="Refresh"/> by default is false indicating that the expiration won't be refreshed.
    /// </remarks>
    /// <exception cref="XSetOperation{TSet}"></exception>
    public async Task<SessionData?> Get(Guid Token, IAccountsDepot Accounts, bool Refresh = false) {
        if (!_sessionsBag.TryGetValue(Token, out SessionScope Session)) {
            return null;
        }

        SessionScope safeSession = Session;
        if (Refresh) {
            safeSession = RefreshToken(Token, Session);
        }

        AuthInput safeCredentials = safeSession.authInput;
        BatchOperationOutput<Account> readAccountOut = await Accounts.Read(
                new QueryInput<Account, FilterQueryInput<Account>> {
                    Parameters = new FilterQueryInput<Account> {
                        Behavior = FilteringBehaviors.First,
                        Filter = i => i.User == safeCredentials.Identity,
                    },
                    PostProcessor = (query) => {
                        return query.Include((Expression<Func<Account, Contact?>>)(i => i.Contact));
                    },
                }
            );

        if (readAccountOut.Failed) {
            throw new XSetOperation<Account>(readAccountOut.Failures);
        }

        Account account = readAccountOut.Successes[0];
        Permit[] permits = await Accounts.GetPermits(account.Id);

        return new SessionData {
            Token = Token,
            Wildcard = account.Wildcard,
            Expiration = safeSession.expiration,
            Account = account,
            Contact = account.Contact,
        };
    }

    /// <summary>
    ///     Tries to get a <see cref="SessionData"/> stored in the context based on the given <paramref name="Token"/>
    /// </summary>
    /// <param name="Token">
    ///     Token to identify the session context.
    /// </param>
    /// <param name="Account">
    ///     The most recent <see cref="Account"/> object for the Session.
    /// </param>
    /// <param name="Permits">
    ///     The most recents <see cref="Permit[]"/> object for the Session.
    /// </param>
    /// <param name="Refresh">
    ///     Indicates if the session was found, refresh its expiration time.
    /// </param>
    /// <returns>
    ///     <see langword="null"/>: The session wasn't found.
    ///     <para> <see cref="SessionData"/>: when it got found. </para>
    /// </returns>
    /// <remarks>
    ///     <paramref name="Refresh"/> by default is false indicating that the expiration won't be refreshed.
    ///     <para> <b>
    ///         This method override allows the invoker to pass directly the <paramref name="Account"/> and <paramref name="Permits"/> directly
    ///         with no needed the method does with the <see cref="AccountsDepot"/> dependency. This removes the need of an async call.
    ///         
    ///         JUST BE SURE YOU'RE PASSING THE MOST RECENT GOT OBJECTS.
    ///     </b> </para>
    /// </remarks>
    /// <exception cref="XSetOperation{TSet}"></exception>
    public SessionData? Get(Guid Token, Account Account, Permit[] Permits, bool Refresh = false) {
        if (!_sessionsBag.TryGetValue(Token, out SessionScope Session)) {
            return null;
        }

        SessionScope safeSession = Session;
        if (Refresh) {
            safeSession = RefreshToken(Token, Session);
        }

        return new SessionData {
            Token = Token,
            Wildcard = Account.Wildcard,
            Expiration = safeSession.expiration,
            Account = Account,
            Contact = Account.Contact,
        };
    }

    #region Public Methods / Functions


    public async Task<SessionData> Auth(AuthInput authInput) {
        HttpContext? reqContext = (authInput.RequestContextAccessor?.HttpContext)
            ?? throw new XAuth(XAuthReasons.NO_REQ_CONTEXT);


        IServiceProvider serviceProvider = reqContext.RequestServices;
        IAccountsService accountsService = serviceProvider.GetRequiredService<IAccountsService>();

        try {
            Account userAccount = await accountsService.Get(authInput.Identity);

            if (!authInput.Password.SequenceEqual(userAccount.Password))
                throw new XAuth(XAuthReasons.NO_REQ_CONTEXT);

            Contact sessionContact = userAccount.Contact;
            sessionContact.Account = null;

            return new SessionData {
                Account = userAccount,
                Expiration = DateTime.Now,
                Token = Guid.NewGuid(),
                Wildcard = userAccount.Wildcard,
                Contact = sessionContact,
            };
        } catch (XRead<Account> readException) when (readException.Reason == XReadReasons.UNFOUND) {
            throw new XAuth(XAuthReasons.UNFOUND_USR);
        }
    }

    #endregion

    #region Private Methods / Functions

    /// <summary>
    ///     Internaly generates and stores into the current manager sessions the given <see cref="AuthInput"/> information.
    /// </summary>
    /// <param name="authInput">
    ///     Authentication input information.
    /// </param>
    /// <exception cref="XAuth">
    ///     For more details check innser <see cref="XAuthReasons"/>.
    /// </exception>
    void GenSession(AuthInput authInput) {
        Guid token = Guid.NewGuid();
        SessionScope sessionScope = (
                authInput,
                DateTime.UtcNow.Add(EXPIRE_THRESHOLD)
            );

        if (_sessionsBag.TryAdd(token, sessionScope)) {
            _tokensBag.Add(token);
            return;
        }

        throw new XAuth(XAuthReasons.NO_REQ_CONTEXT);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Token"></param>
    /// <param name="Session"></param>
    /// <returns></returns>
    /// <exception cref="XAuth"></exception>
    /// <exception cref="XAuthReasons.UNSAFE_UPDATE"></exception>
    SessionScope RefreshToken(Guid Token, SessionScope Session) {
        (AuthInput Credentials, DateTime Expiration) safeUpdate = (Session.authInput, DateTime.UtcNow.Add(EXPIRE_THRESHOLD));

        return _sessionsBag.TryUpdate(Token, safeUpdate, Session)
            ? safeUpdate
            : throw new XAuth(XAuthReasons.NO_REQ_CONTEXT);
    }

    #endregion
}
