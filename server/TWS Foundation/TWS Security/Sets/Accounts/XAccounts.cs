using System.Net;

using CSM_Foundation.Core.Bases;

namespace TWS_Security.Sets.Accounts;


public class XAccounts
    : BException<XAccountsSituations> {
    public XAccounts(XAccountsSituations Situation) 
        : base("Account Set", Situation, HttpStatusCode.InternalServerError, null) {
    }

    protected override Dictionary<XAccountsSituations, string> AdviseFactory() {
        return [];
    }
}

public enum XAccountsSituations {

}