using System.Net;

using CSM_Foundation.Core.Bases;
using CSM_Foundation.Core.Constants;

namespace TWS_Customer.Managers.Exceptions;
public class XConfigurationManager
    : BException<XConfigurationManagerSituation> {
    public XConfigurationManager(XConfigurationManagerSituation Situation, Exception? System = null) 
        : base($"Configuration Manager Exception | [{Situation}]", HttpStatusCode.InternalServerError, System) {

        this.Situation = Situation;
        Advise = AdvisesConstants.SERVER_CONTACT_ADVISE;


    }
}

public enum XConfigurationManagerSituation {
    UnfoundDirectory,
    UnfoundConfiguration,
    UnfoundSolutionConfiguration,
}