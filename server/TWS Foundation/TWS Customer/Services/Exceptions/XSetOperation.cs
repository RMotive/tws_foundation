using System.Net;

using CSM_Foundation.Core.Constants;
using CSM_Foundation.Core.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Models;

namespace TWS_Customer.Services.Exceptions;
public class XSetOperation<TSet>
    : BException<XTransactionSituation>
    where TSet: IEntity {
    public XSetOperation(EntityOperationFailure<TSet>[] Failures)
        : base($"Set operation has failed", XTransactionSituation.Failed, HttpStatusCode.InternalServerError, null) {
        Advise = AdvisesConstants.SERVER_CONTACT_ADVISE;

        Factors = Failures.ToDictionary<EntityOperationFailure<TSet>, string, dynamic>(i => $"{i.Entity.GetType()}({i.Entity.Id})", i => i.Exception.Message);
        Details = Factors;
    }
}

public enum XTransactionSituation {
    Failed,
}
