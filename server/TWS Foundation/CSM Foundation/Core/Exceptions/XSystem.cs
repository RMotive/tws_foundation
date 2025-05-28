using System.Net;

using CSM_Foundation.Core.Bases;

namespace CSM_Foundation.Core.Exceptions;
public class XSystem
    : BException<XSystemSituations> {
    public XSystem(Exception Exception)
        : base("Exception exception caught on transaction operation", XSystemSituations.System, HttpStatusCode.InternalServerError, Exception) {

        Situation = XSystemSituations.System;
        Factors = new() {
            { "Exception", Exception.Message }
        };
    }

    protected override Dictionary<XSystemSituations, string> ResolveAdvise() {
        return [];
    }
}

public enum XSystemSituations {
    System
}