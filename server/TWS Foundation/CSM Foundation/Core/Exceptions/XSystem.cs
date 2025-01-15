using System.Net;

using CSM_Foundation.Core.Bases;

namespace CSM_Foundation.Core.Exceptions;
public class XSystem
    : BException<XSystemSituations> {
    public XSystem(Exception Exception)
        : base("SystemInternal exception caught on transaction operation", HttpStatusCode.InternalServerError, Exception) {

        Situation = XSystemSituations.System;
        Advise = "Contact your service administrator";
        Factors = new() {
            { "SystemInternal", Exception.Message }
        };
    }
}

public enum XSystemSituations {
    System
}