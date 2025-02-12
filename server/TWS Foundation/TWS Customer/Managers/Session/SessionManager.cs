using System.Collections.Concurrent;

using CSM_Foundation.Database.Enumerators;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Customer.Managers.Session.Exceptions;
using TWS_Customer.Services.Exceptions;
using TWS_Customer.Services.Records;

using TWS_Security.Sets;
using TWS_Security.Sets.Accounts;
using TWS_Security.Sets.Contacts;

using CredentialsExpiration = (TWS_Customer.Services.Records.Credentials Credentials, System.DateTime Expiration);

namespace TWS_Customer.Managers.Session;

/// <summary>
/// 
/// </summary>
public record Session {
    public required Guid Token { get; init; }
    public required DateTime Expiration { get; init; }
    public required string Identity { get; init; }
    public required bool Wildcard { get; init; }
    public required Permit[] Permits { get; init; }
    public required Contact Contact { get; init; }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public Session Copy(Guid? Token = null, DateTime? Expiration = null, string? Identity = null, bool? Wildcard = null, Permit[]? Permits = null, Contact? Contact = null) {
        return new Session {
            Token = Token ?? this.Token,
            Expiration = Expiration ?? this.Expiration,
            Identity = Identity ?? this.Identity,
            Wildcard = Wildcard ?? this.Wildcard,
            Permits = Permits ?? this.Permits,
            Contact = Contact ?? this.Contact
        };
    }
}

/// <summary>
///     Manager that handles all the sessions currently operating in all TWS solutions environment.
/// </summary>
public sealed class SessionManager {
    private readonly TimeSpan EXPIRATION_RANGE = TimeSpan.FromHours(3);
    private readonly ConcurrentDictionary<Guid, CredentialsExpiration> CurrentSessions = [];
    private readonly ConcurrentBag<Guid> CurrentTokens = [];


    /// <summary>
    ///     Authorizes the given <paramref name="Credentials"/> unsafely into the current [Sessions] context.
    /// </summary>
    /// <remarks>
    ///       <b> Warning: </b> With unsafely we are refering to this method at first instance doesn't check if the <paramref name="Credentials"/> exist and are valid, that
    ///       was a work of the method that invoked this one.
    /// </remarks>
    /// <exception cref="XSessionManager"></exception>
    /// <exception cref="XSessionManagerSituations.UNSAFE_TOKEN"></exception>
    public Guid Authorize(Credentials Credentials) {
        Guid safeToken = GenerateToken();

        GenerateSession(safeToken, Credentials);
        return safeToken;
    }

    /// <summary>
    ///     Tries to get a <see cref="Session"/> stored in the context based on the given <paramref name="Token"/>
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
    ///     <para> <see cref="Session"/>: when it got found. </para>
    /// </returns>
    /// <remarks>
    ///     <paramref name="Refresh"/> by default is false indicating that the expiration won't be refreshed.
    /// </remarks>
    /// <exception cref="XSetOperation{TSet}"></exception>
    public async Task<Session?> Get(Guid Token, IAccountsDepot Accounts, bool Refresh = false) {
        if (!CurrentSessions.TryGetValue(Token, out CredentialsExpiration Session)) {
            return null;
        }

        CredentialsExpiration safeSession = Session;
        if (Refresh) {
            safeSession = RefreshToken(Token, Session);
        }

        Credentials safeCredentials = safeSession.Credentials;
        SetBatchOut<Account> readAccountOut = await Accounts.Read(
            (i) => i.User == safeCredentials.Identity,
            SetReadBehaviors.First,
            (query) => {
                return query
                    .Include(i => i.ContactNavigation);
            }
        );

        if (readAccountOut.Failed) {
            throw new XSetOperation<Account>(readAccountOut.Failures);
        }

        Account account = readAccountOut.Successes[0];
        Permit[] permits = await Accounts.GetPermits(account.Id);

        return new Session {
            Token = Token,
            Permits = permits,
            Contact = account.ContactNavigation!,
            Wildcard = account.Wildcard,
            Identity = Session.Credentials.Identity,
            Expiration = safeSession.Expiration,
        };
    }

    /// <summary>
    ///     Tries to get a <see cref="Session"/> stored in the context based on the given <paramref name="Token"/>
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
    ///     <para> <see cref="Session"/>: when it got found. </para>
    /// </returns>
    /// <remarks>
    ///     <paramref name="Refresh"/> by default is false indicating that the expiration won't be refreshed.
    ///     
    ///     
    ///     
    ///     <para> <b>
    ///         This method override allows the invoker to pass directly the <paramref name="Account"/> and <paramref name="Permits"/> directly
    ///         with no needed the method does with the <see cref="AccountsDepot"/> dependency. This removes the need of an async call.
    ///         
    ///         JUST BE SURE YOU'RE PASSING THE MOST RECENT GOT OBJECTS.
    ///     </b> </para>
    /// </remarks>
    /// <exception cref="XSetOperation{TSet}"></exception>
    public Session? Get(Guid Token, Account Account, Permit[] Permits, bool Refresh = false) {
        if (!CurrentSessions.TryGetValue(Token, out CredentialsExpiration Session)) {
            return null;
        }

        CredentialsExpiration safeSession = Session;
        if (Refresh) {
            safeSession = RefreshToken(Token, Session);
        }

        return new Session {
            Token = Token,
            Permits = Permits,
            Contact = Account.ContactNavigation!,
            Wildcard = Account.Wildcard,
            Identity = Session.Credentials.Identity,
            Expiration = safeSession.Expiration,
        };
    }



    /// <summary>
    ///     Generates a safe <see cref="Guid"/> token looking at the currently created ones.
    /// </summary>
    /// <returns> Safe Token </returns>
    private Guid GenerateToken() {
        Guid tempGuid;

        do {
            tempGuid = Guid.NewGuid();
        } while (CurrentTokens.Contains(tempGuid));

        return tempGuid;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Token"></param>
    /// <param name="Session"></param>
    /// <returns></returns>
    /// <exception cref="XSessionManager"></exception>
    /// <exception cref="XSessionManagerSituations.UNSAFE_UPDATE"></exception>
    private CredentialsExpiration RefreshToken(Guid Token, CredentialsExpiration Session) {
        (Credentials Credentials, DateTime Expiration) safeUpdate = (Session.Credentials, DateTime.UtcNow.Add(EXPIRATION_RANGE));

        return CurrentSessions.TryUpdate(Token, safeUpdate, Session)
            ? safeUpdate
            : throw new XSessionManager(XSessionManagerSituations.UNSAFE_UPDATE);
    }

    /// <summary>
    ///     Safely creates and subscribes a new session to <see cref="CurrentSessions"/> context.
    /// </summary>
    /// <param name="SafeToken">
    ///     Expected a completely safe token to set session key.
    /// </param>
    /// <param name="Credentials">
    ///     Credentials to identify account changes and permit calculations.
    /// </param>
    /// <exception cref="XSessionManager"></exception>
    /// <exception cref="XSessionManagerSituations.UNSAFE_TOKEN"></exception>
    private void GenerateSession(Guid SafeToken, Credentials Credentials) {
        CredentialsExpiration safeExpiration = (Credentials, DateTime.UtcNow.Add(EXPIRATION_RANGE));

        if (CurrentSessions.TryAdd(SafeToken, safeExpiration)) {
            CurrentTokens.Add(SafeToken);
            return;
        }

        throw new XSessionManager(XSessionManagerSituations.UNSAFE_TOKEN);
    }
}
