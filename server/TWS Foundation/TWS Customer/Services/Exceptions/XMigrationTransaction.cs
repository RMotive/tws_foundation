using System.Net;

using CSM_Foundation.Core.Constants;
using CSM_Foundation.Server.Bases;
using CSM_Foundation.Databases.Models;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Bases;

namespace TWS_Customer.Services.Exceptions;
public class XMigrationTransaction<TSet> 
    : BServerTransactionException<XTransactionSituation> where TSet : IDatabasesSet {
    public XMigrationTransaction(SourceTransactionFailure<TSet>[] Failures)
        : base($"Migration transaction has failed", HttpStatusCode.InternalServerError, null) {
        Situation = XTransactionSituation.Failed;
        Advise = AdvisesConstants.SERVER_CONTACT_ADVISE;

        Factors = Failures.ToDictionary<SourceTransactionFailure<TSet>, string, dynamic>(i => $"{i.Set.GetType()}({i.Set.Id})", i => i.SystemInternal.Message);
        Details = Factors;
    }
}

public enum XTransactionSituation {
    Failed,
}
