using System.Net;

using CSM_Foundation.Core.Bases;
using CSM_Foundation.Core.Constants;

namespace TWS_Customer.Services.Exceptions;
public class XAuthenticate
    : BException<XAuthenticateSituation> {
    public XAuthenticate(XAuthenticateSituation Situation)
        : base($"Authentication request has failed", Situation, HttpStatusCode.Unauthorized, null) {

        this.Situation = Situation;
        Advise = Situation switch {
            XAuthenticateSituation.IDENTITY_UNFOUND => $"Identity not found",
            XAuthenticateSituation.WRONG_PASSWORD => $"Wrong password",
            XAuthenticateSituation.SOLUTION_DISABLED => $"The solution is currently disabled",
            XAuthenticateSituation.UNAUTHORIZED_SOLUTION => $"Unathurozied access to that solution",
            _ => AdvisesConstants.SERVER_CONTACT_ADVISE,
        };
    }
}

/// <summary>
///     <see cref="XAuthenticate"/> exception situations.
/// </summary>
public enum XAuthenticateSituation {
    /// <summary>
    ///     When the identity doesn't exist in the system.
    /// </summary>
    IDENTITY_UNFOUND,
    /// <summary>
    ///     When the password is incorrect for the found identity.
    /// </summary>
    WRONG_PASSWORD,
    /// <summary>
    ///     When the solution the user is trying to access is disabled.
    /// </summary>
    SOLUTION_DISABLED,
    /// <summary>
    ///     When the user doesn't have permit to access the requested solution.
    /// </summary>
    UNAUTHORIZED_SOLUTION,
    /// <summary>
    ///     When the requested token doesn't have a current session after create it.
    /// </summary>
    SESSION_UNFOUND,
}