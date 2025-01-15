using System.Net;

using CSM_Foundation.Core.Constants;
using CSM_Foundation.Database.Models;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Core.Bases;

namespace TWS_Customer.Services.Exceptions;
public class XSetOperation<TSet>
    : BException<XTransactionSituation>
    where TSet: ISet {
    public XSetOperation(SetOperationFailure<TSet>[] Failures)
        : base($"Set operation has failed", HttpStatusCode.InternalServerError, null) {
        Situation = XTransactionSituation.Failed;
        Advise = AdvisesConstants.SERVER_CONTACT_ADVISE;

        Factors = Failures.ToDictionary<SetOperationFailure<TSet>, string, dynamic>(i => $"{i.Set.GetType()}({i.Set.Id})", i => i.SystemInternal.Message);
        Details = Factors;
    }
}

public enum XTransactionSituation {
    Failed,
}
