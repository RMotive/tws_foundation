using System.Net;

using CSM_Foundation.Core.Constants;
using CSM_Foundation.Server.Bases;
using CSM_Foundation.Database.Models;

namespace TWS_Customer.Services.Exceptions;
public class XMigrationTransaction
    : BServerTransactionException<XTransactionSituation> {
    public XMigrationTransaction(SetComplexFailure[] Failures)
        : base($"Migration transaction has failed", HttpStatusCode.InternalServerError, null) {
        Situation = XTransactionSituation.Failed;
        Advise = AdvisesConstants.SERVER_CONTACT_ADVISE;

        Factors = Failures.ToDictionary<SetComplexFailure, string, dynamic>(i => $"{i.Set.GetType()}({i.Set.Id})", i => i.SystemInternal.Message);
        Details = Factors;
    }
}

public enum XTransactionSituation {
    Failed,
}
