using System.Net;

using CSM_Foundation.Core.Constants;
using CSM_Foundation.Server.Bases;

namespace TWS_Customer.Managers.Exceptions;
public class XConfigurationManager
    : BServerTransactionException<XConfigurationManagerSituation> {
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