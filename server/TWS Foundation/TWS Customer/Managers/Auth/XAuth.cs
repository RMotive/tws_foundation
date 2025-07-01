using System.Net;

using CSM_Foundation.Core.Bases;

using TWS_Customer.Managers.Auth;

namespace TWS_Customer.Managers.Session;

/// <summary>
///     <see cref="XAuth"/> exception situations.
/// </summary>
public enum XAuthReasons {
    /// <summary>
    ///     When the user wasn't found in the system.
    /// </summary>
    UNFOUND_USR,

    /// <summary>
    ///     When the user password is incorrect.
    /// </summary>
    WRONG_PWD,

    /// <summary>
    ///     When the global solution access is disabled.
    /// </summary>
    DIS_SOLUTION,

    /// <summary>
    ///     When the auth process finds out the user credentials doesn't have auth level to access requested feature.
    /// </summary>
    UNAUTHORIZED,

    /// <summary>
    ///     When the <see cref="IAuthManager.Auth(Services.Records.AuthInput)"/> requires the request context scope but is not being given.
    /// </summary>
    NO_REQ_CONTEXT,
}

/// <summary>
///     {exception} implementation to handle {Auth} scoped exceptions.
/// </summary>
public class XAuth
    : BException<XAuthReasons> {

    /// <summary>
    ///     Generates a new <see cref="XAuth"/> custom exception.
    /// </summary>
    /// <param name="reason">
    ///     Specifies the <see cref="XAuthReasons"/> that caused the exception.
    /// </param>
    /// <param name="System">
    ///     Indicates if the cause was due to a unrecognized system exception was caugth.
    /// </param>
    public XAuth(XAuthReasons reason, Exception? System = null)
        : base($"Auth Exception", reason, HttpStatusCode.InternalServerError, System) {
    }

    protected override Dictionary<XAuthReasons, string> ResolveAdvise() {
        return new Dictionary<XAuthReasons, string> {
            { XAuthReasons.UNFOUND_USR, $"Identity not found" },
            { XAuthReasons.WRONG_PWD, $"Wrong password" },
            { XAuthReasons.DIS_SOLUTION, $"The solution is currently disabled" },
            { XAuthReasons.UNAUTHORIZED, $"Unathurozied feature access" },
        };
    }
}