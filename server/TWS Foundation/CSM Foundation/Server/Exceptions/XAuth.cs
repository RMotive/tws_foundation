using System.Net;

using CSM_Foundation.Core.Bases;
using CSM_Foundation.Core.Constants;

namespace CSM_Foundation.Server.Exceptions;
public class XAuth
    : BException<XAuthSituation> {



    public XAuth(XAuthSituation Situation)
        : base($"Unauthorized transaction request", HttpStatusCode.Unauthorized, null) {
        this.Situation = Situation;
        Advise = Situation switch {
            XAuthSituation.Lack => AdvisesConstants.SERVER_CONTACT_ADVISE,
            XAuthSituation.Unauthorized => $"Account is unautorized to the requested feature",
            XAuthSituation.Format => $"Wrong authentication format {AdvisesConstants.SERVER_CONTACT_ADVISE}",
            XAuthSituation.SystemUCL | XAuthSituation.SystemACL => $"Unrecognized system exception, {AdvisesConstants.SERVER_CONTACT_ADVISE}",
            _ => AdvisesConstants.SERVER_CONTACT_ADVISE,
        };
    }
}

public enum XAuthSituation {
    /// <summary>
    ///     When the auth header wasn't found.
    /// </summary>
    Lack,
    /// <summary>
    ///     When the auth token isn't in a propertly format.
    /// </summary>
    Format,
    /// <summary>
    ///     When the acount isn't authorized to the requested features/actions/solutions.
    /// </summary>
    Unauthorized,
    /// <summary>
    ///     When a system unrecognized exception is catched.
    /// </summary>
    SystemUCL,
    /// <summary>
    ///     When a system recognized exception is catched
    /// </summary>
    SystemACL,
}