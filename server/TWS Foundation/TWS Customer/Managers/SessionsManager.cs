using System.Collections.Concurrent;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Server.Exceptions;

using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Records;

using TWS_Security.Sets;

namespace TWS_Customer.Managers;
/// <summary>
/// 
/// </summary>
public sealed class SessionsManager {
    private static SessionsManager? Instance;
    public static SessionsManager Manager => Instance ??= new SessionsManager();

    private readonly TimeSpan EXPIRATION_RANGE = TimeSpan.FromHours(2);

    private readonly ConcurrentDictionary<string, Session> SESSIONS = [];
    
    SessionsManager() { }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Expiration"></param>
    /// <returns></returns>
    private static bool EvaluateAlive(DateTime Expiration) {
        return DateTime.Compare(DateTime.Now, Expiration) >= 0;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    private Guid Tokenize() {
        Guid token = Guid.NewGuid();

        if (!SESSIONS.TryGetValue(token.ToString(), out Session? _)) 
            return token;
       
       return Tokenize();
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="TokenOrIdentity"></param>
    /// <returns></returns>
    private Session? Clean(string TokenOrIdentity) {
        KeyValuePair<string, Session>? sessionEntry = SESSIONS.Where(
            (KeyValuePair<string, Session> i) => {
                if(i.Key == TokenOrIdentity) 
                    return true;
                else if (i.Value.Identity == TokenOrIdentity)
                    return true;

                return false;
            }
        ).FirstOrDefault(); 


        if (sessionEntry.Value.Key is null) 
            return null;

        KeyValuePair<string, Session> session = sessionEntry.Value;
        if (DateTime.Compare(DateTime.UtcNow, session.Value.Expiration) < 0) 
            return session.Value;

        SESSIONS.TryRemove(session.Key, out Session? Entry);
        return null;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Session"></param>
    /// <returns></returns>
    private Session Refresh(Session Session) {
        KeyValuePair<string, Session> sessionEntry = SESSIONS
            .Where(i => i.Value.Identity == Session.Identity)
            .First();

        Session refreshed = sessionEntry.Value.Copy(Expiration: DateTime.UtcNow.Add(EXPIRATION_RANGE));

        if(SESSIONS.TryUpdate(sessionEntry.Key, refreshed, sessionEntry.Value)) { 
            return refreshed;        
        } else throw new XAuth(XAuthSituation.SystemUCL);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Credentials"></param>
    /// <param name="Wildcard"></param>
    /// <param name="Permits"></param>
    /// <param name="Contact"></param>
    /// <returns></returns>
    public Session Subscribe(Credentials Credentials, bool Wildcard, Permit[] Permits, Contact Contact) {
        Session? session = Clean(Credentials.Identity);

        if (session is not null) {
            return Refresh(session);
        }

        Guid caledToken = Tokenize();
        session = new() {
            Expiration = DateTime.Now.Add(EXPIRATION_RANGE),
            Token = caledToken,
            Identity = Credentials.Identity,
            Wildcard = Wildcard,
            Permits = Permits,
            Contact = Contact
        };

        if(SESSIONS.TryAdd(caledToken.ToString(),  session)) {
            return session;
        } else throw new XAuth(XAuthSituation.SystemACL);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Token"></param>
    /// <returns></returns>
    public bool EvaluateExpiration(string Token) {
        Session? session = Clean(Token);
        return session is not null && EvaluateAlive(session.Expiration);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Token"></param>
    /// <returns></returns>
    public bool EvaluateWildcard(string Token) {
        Session? session = Clean(Token);
        return session is not null && session.Wildcard;
    }
}
