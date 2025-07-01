using System.Net;

using CSM_Foundation.Core.Bases;

namespace CSM_Security.Depots.Exceptions;


public class XAccounts
    : BException<XAccountsSituations> {
    public XAccounts(XAccountsSituations Situation) 
        : base("Account Set", Situation, HttpStatusCode.InternalServerError, null) {
    }

    protected override Dictionary<XAccountsSituations, string> ResolveAdvise() {
        return [];
    }
}

public enum XAccountsSituations {

}