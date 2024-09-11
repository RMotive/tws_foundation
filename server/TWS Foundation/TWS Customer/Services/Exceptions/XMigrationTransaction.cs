using System.Net;

using CSM_Foundation.Core.Constants;
using CSM_Foundation.Server.Bases;
using CSM_Foundation.Database.Models;
using CSM_Foundation.Database.Interfaces;

namespace TWS_Customer.Services.Exceptions;
public class XMigrationTransaction<TSet>
    : BServerTransactionException<XTransactionSituation>
    where TSet: ISet {
    public XMigrationTransaction(SetOperationFailure<TSet>[] Failures)
        : base($"Migration transaction has failed", HttpStatusCode.InternalServerError, null) {
        Situation = XTransactionSituation.Failed;
        Advise = AdvisesConstants.SERVER_CONTACT_ADVISE;

        Factors = Failures.ToDictionary<SetOperationFailure<TSet>, string, dynamic>(i => $"{i.Set.GetType()}({i.Set.Id})", i => i.SystemInternal.Message);
        Details = Factors;
    }
}

public enum XTransactionSituation {
    Failed,
}
