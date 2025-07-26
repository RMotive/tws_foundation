using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business;
using TWS_Business.Depots.Indicators;
using TWS_Business.Entities;


namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Status"/> based [Service] implementations.
/// </summary>
public interface IStatusesService
    : IService<Status> {
}


/// <summary>
///     [Service] for <see cref="Status"/> based operations.
/// </summary>
public class StatusesService
    : BService<Status, StatusesDepot>, IStatusesService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="StatusService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref=""/> based [Depot] handler to be used.
    /// </param>
    public StatusesService(StatusesDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }

    public async override Task<BatchOperationOutput<Status>> Create(Status[] Entities, bool Sync = false) {
        Status[] successes = [];
        EntityOperationFailure<Status>[] failures = [];

        foreach (Status entity in Entities) {
            try {
                Status attachedEntity = await _depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Status> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Status> output = new(successes, failures);

        return output;
    }
}
