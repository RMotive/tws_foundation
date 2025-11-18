using CSM_Foundation;
using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Indicators;
using TWS_Business.Entities;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Situation"/> based [Service] implementations.
/// </summary>
public interface ISituationsService
    : IReferenceService<Situation> {
}

/// <summary>
///     [Service] for <see cref="Situation"/> based operations.
/// </summary>
public class SituationsService
    : BReferenceService<Situation, SituationsDepot>, ISituationsService {

    /// <summary>
    ///     Creates a new instance of <see cref="SituationsService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Situation"/> based [Depot] handler to be used.
    /// </param>
    public SituationsService(SituationsDepot Depot) : base(Depot) { }

    public async override Task<BatchOperationOutput<Situation>> Create(Situation[] Entities, bool Sync = false) {
        Situation[] successes = [];
        EntityOperationFailure<Situation>[] failures = [];

        foreach (Situation entity in Entities) {
            try {
                Situation attachedEntity = await _depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Situation> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        BatchOperationOutput<Situation> output = new(successes, failures);

        return output;
    }
}
