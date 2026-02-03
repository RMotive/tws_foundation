using System.Net;

using CSM_Database_Core.Core.Errors;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation.Core.Bases;

namespace TWS_Customer.Services.Exceptions;
public class XSetOperation<TSet>
    : BException<XTransactionSituation>
    where TSet : IEntity {
    public XSetOperation(EntityError<TSet>[] Failures)
        : base($"Set operation has failed", XTransactionSituation.Failed, HttpStatusCode.InternalServerError, null) {

        Factors = Failures.ToDictionary<EntityError<TSet>, string, dynamic>(i => $"{i.Entity.GetType()}({i.Entity.Id})", i => i.Exception != null? i.Exception.Message : "No Excepcion message");
        Details = Factors;
    }

    protected override Dictionary<XTransactionSituation, string> ResolveAdvise() {
        return [];
    }
}

public enum XTransactionSituation {
    Failed,
}
