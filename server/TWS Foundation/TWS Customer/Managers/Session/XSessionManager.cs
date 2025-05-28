using System.Net;

using CSM_Foundation.Core.Bases;

namespace TWS_Customer.Managers.Session;

/// <summary>
///     Custom <see cref="Exception"/> to handle <see cref="SessionManager"/> exceptions.
/// </summary>
public class XSessionManager
    : BException<XSessionManagerSituations> {

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
        : base($"Session Manager Exception | [{Situation}]", Situation, HttpStatusCode.InternalServerError, System) {

        this.Situation = Situation;
    }

    protected override Dictionary<XSessionManagerSituations, string> ResolveAdvise() {
        return [];
    }
}

/// <summary>
///     <see cref="XSessionManager"/> exception situations.
/// </summary>
public enum XSessionManagerSituations {
    /// <summary>
    ///     When the <see cref="ISessionManager.Action(Services.Records.AuthInput)"/> requires the request context scope but is not being given.
    /// </summary>
    NO_REQ_CONTEXT,
}