using System.Collections.Concurrent;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Primitives;

using TWS_Customer.Features;
using TWS_Customer.Features.Security;
using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Records;

using SessionsBag = System.Collections.Concurrent.ConcurrentDictionary<System.Guid, (TWS_Customer.Services.Records.AuthInput Credentials, System.DateTime Expiration)>;
using SessionScope = (TWS_Customer.Services.Records.AuthInput authInput, System.DateTime expiration);

namespace TWS_Customer.Managers.Auth;

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
    ///     Authenticates an user from the given <paramref name="authInput"/> information.
    /// </summary>
    /// <param name="authInput">
    ///     Input parameters.
    /// </param>
    /// <returns>
    ///     The correct authenticated <see cref="SessionData"/> information.
    /// </returns>
    public Task<SessionData> Auth(AuthInput authInput);

    /// <summary>
    ///     Gets the <see cref="SessionData"/> from the transaction user. 
    /// </summary>
    /// <returns>
    ///     The found <see cref="SessionData"/> information.
    /// </returns>
    public Task<SessionData> Get();
}

/// <summary>
///     {Manager} implementation that handles all the sessions currently operating in all TWS solutions environment.
/// </summary>
public sealed class AuthManager
    : IAuthManager {

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
    ///     {dep} Allows to access and handle transaction contexts.
    /// </summary>
    readonly IHttpContextAccessor _contextAccessor;

    /// <summary>
    ///     Creaes a new <see cref="AuthManager"/> instance.
    /// </summary>
    public AuthManager(
            IHttpContextAccessor contextAccesor
        ) {
        _contextAccessor = contextAccesor;
    }

    /// <summary>
    ///     Gets the current transaction context data.
    /// </summary>
    HttpContext Transaction {
        get {
            return _contextAccessor.HttpContext ?? throw new XAuth(XAuthReasons.NO_REQ_CONTEXT);
        }
    }

    /// <summary>
    ///     Gets the current transaction context auth header value.
    /// </summary>
    string TransactionAuth {
        get {

            IHeaderDictionary reqHeaders = Transaction.Request.Headers;

            StringValues authHeader = reqHeaders.Authorization;

            return authHeader.ToString();
        }
    }

    /// <summary>
    ///     Gets the current transaction context auth token being used.
    /// </summary>
    string TransactionAuthToken {
        get {
            return TransactionAuth.Split('@')[0].Replace($"CSMAuth ", "");
        }
    }

    public async Task<SessionData> Auth(AuthInput input) {

        SessionData sessionData = await GenSession(input);
        StoreSession(input, sessionData);

        return sessionData;
    }

    public async Task<SessionData> Get() {
        string token = TransactionAuthToken;

        Guid sessionToken = Guid.Parse(token);

        if (!_sessionsBag.TryGetValue(sessionToken, out SessionScope sessionScope)) {
            throw new XAuth(XAuthReasons.UNK_TOKEN);
        }

        return await GenSession(sessionScope.authInput);
    }

    /// <summary>
    ///     Generates the <see cref="SessionData"/> from the given <paramref name="input"/>, checking if the account identity and password
    ///     matches solution stored ones.
    /// </summary>
    /// <returns>
    ///     Session related information.
    /// </returns>
    async Task<SessionData> GenSession(AuthInput input) {
        HttpContext transaction = Transaction;

        IServiceProvider serviceProvider = transaction.RequestServices;
        IAccountsService accountsService = serviceProvider.GetRequiredService<IAccountsService>();

        try {
            Account userAccount = await accountsService.Get(input.Identity);

            if (!input.Password.SequenceEqual(userAccount.Password))
                throw new XAuth(XAuthReasons.NO_REQ_CONTEXT);

            Contact sessionContact = userAccount.Contact;
            sessionContact.Account = null;

            return new SessionData {
                Account = userAccount,
                Expiration = DateTime.Now.Add(EXPIRE_THRESHOLD),
                Token = Guid.NewGuid(),
                Wildcard = userAccount.Wildcard,
                Contact = sessionContact,
            };
        } catch (XRead<Account> readException) when (readException.Reason == XReadReasons.UNFOUND) {
            throw new XAuth(XAuthReasons.UNFOUND_USR);
        }
    }

    /// <summary>
    ///     Internaly generates and stores into the current manager sessions the given <see cref="AuthInput"/> information.
    /// </summary>
    /// <param name="authInput">
    ///     Authentication input information.
    /// </param>
    /// <exception cref="XAuth">
    ///     For more details check innser <see cref="XAuthReasons"/>.
    /// </exception>
    void StoreSession(AuthInput input, SessionData sessionData) {
        SessionScope sessionScope = (
                input,
                sessionData.Expiration
            );

        if (_sessionsBag.TryAdd(sessionData.Token, sessionScope)) {
            _tokensBag.Add(sessionData.Token);
            return;
        }

        throw new XAuth(XAuthReasons.NO_REQ_CONTEXT);
    }
}
