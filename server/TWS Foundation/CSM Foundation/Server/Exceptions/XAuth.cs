using System.Net;

using CSM_Foundation.Core.Bases;
using CSM_Foundation.Core.Constants;

namespace CSM_Foundation.Server.Exceptions;

/// <summary>
///     {exception} class from <see cref="BException{XAuthSituation}"/>.
///     
///     <para>
///         Defines an exception object thrown at {Authentication} server processes. 
///     </para>
/// </summary>
public class XAuth
    : BException<XAuthSituation> {

    /// <summary>
    ///     Creates a new <see cref="XAuth"/> instance.
    /// </summary>
    /// <param name="siutation">
    ///     Exception invokation situation.
    /// </param>
    public XAuth(XAuthSituation siutation)
        : base($"Unauthorized server transaction", siutation, HttpStatusCode.Unauthorized, null) {
    }

    protected override Dictionary<XAuthSituation, string> ResolveAdvise() {

        return new Dictionary<XAuthSituation, string> {
            { XAuthSituation.NO_TOKEN, AdvisesConstants.SERVER_CONTACT_ADVISE },
            { XAuthSituation.WRONG_TOKEN_FORMAT,  $"Wrong authentication format {AdvisesConstants.SERVER_CONTACT_ADVISE}" },
            { XAuthSituation.Unauthorized, $"Account is unautorized to the requested feature" },
            { XAuthSituation.SystemException, $"Unrecognized system exception, {AdvisesConstants.SERVER_CONTACT_ADVISE}" },
            { XAuthSituation.ProcessException, $"Unrecognized system exception, {AdvisesConstants.SERVER_CONTACT_ADVISE}" },
            { XAuthSituation.TokenExpired, $"Your session token is expired" },
        };
    }
}

/// <summary>
///     <see langword="enum"/> implementation.
///     
///     <para>
///         Defines the available possible {Situations} for <see cref="XAuth"/> exception invokation.
///     </para>
/// </summary>
public enum XAuthSituation {
    /// <summary>
    ///     When the auth header wasn't found.
    /// </summary>
    NO_TOKEN,
    /// <summary>
    ///     When the auth token isn't in a propertly format.
    /// </summary>
    WRONG_TOKEN_FORMAT,
    /// <summary>
    ///     When the acount isn't authorized to the requested features/actions/solutions.
    /// </summary>
    Unauthorized,
    /// <summary>
    ///     When a system unrecognized exception is catched.
    /// </summary>
    SystemException,
    /// <summary>
    ///     When a system recognized exception is catched
    /// </summary>
    ProcessException,
    /// <summary>
    ///     Session token expired.
    /// </summary>
    TokenExpired,
}