using System.Net;

using CSM_Foundation.Core.Bases;

namespace CSM_Foundation.Core;



public class XSystem
    : BException<XSystemReasons> {
    public XSystem(string serverMessage, Exception? exception)
        : base("System exception thrown", 
            XSystemReasons.SYS, 
            HttpStatusCode.InternalServerError, 
            exception
        ) {

        Factors = new() {
            { "ServerMessage", serverMessage },
            { "Exception", exception?.Message ?? "" }
        };
    }

    protected override Dictionary<XSystemReasons, string> ResolveAdvise() {
        /// Sending empty to resolve always the Contact Server Administrator advise.
        return [];
    }
}

/// <summary>
///     Enumerator to store the available exception reasons for <see cref="XSystem"/>.
/// </summary>
public enum XSystemReasons {
    /// <summary>
    ///     Exception thrown by specific system methods. 
    /// </summary>
    SYS
}