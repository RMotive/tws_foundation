using System.Net;

using CSM_Foundation.Core.Constants;
using CSM_Foundation.Server.Bases;

namespace TWS_Customer.Managers.Exceptions;

/// <summary>
///     Custom <see cref="Exception"/> to handle <see cref="SessionManager"/> exceptions.
/// </summary>
public class XSessionManager
    : BServerTransactionException<XSessionManagerSituations> {

    /// <summary>
    ///     Generates a new <see cref="XSessionManager"/> custom exception.
    /// </summary>
    /// <param name="Situation">
    ///     Specifies the <see cref="XSessionManagerSituations"/> that caused the exception.
    /// </param>
    /// <param name="System">
    ///     Indicates if the cause was due to a unrecognized system exception was caugth.
    /// </param>
    public XSessionManager(XSessionManagerSituations Situation, Exception? System = null)
        : base($"Session Manager Exception | [{Situation}]", HttpStatusCode.InternalServerError, System) {

        this.Situation = Situation;
        Advise = AdvisesConstants.SERVER_CONTACT_ADVISE;
    }
}

/// <summary>
///     <see cref="XSessionManager"/> exception situations.
/// </summary>
public enum XSessionManagerSituations {
    /// <summary>
    ///     When the manager tried to add an unsafe token to the Sessions context.
    /// </summary>
    UNSAFE_TOKEN,
    /// <summary>
    ///     When the session context was tried to be modified but another transaction already changed it.
    /// </summary>
    UNSAFE_UPDATE
}