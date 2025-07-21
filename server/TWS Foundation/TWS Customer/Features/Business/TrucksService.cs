using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Truck_Common"/> based [Service] implementations.
/// </summary>
public interface ITrucksCommonService
    : IService<Truck_Common> {
}

/// <summary>
///     [Service] for <see cref="Address"/> based operations.
/// </summary>
public class TrucksService
    : BService<Truck_Common, TrucksDepot>, ITrucksCommonService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="TrucksService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Truck_Common"/> based [Depot] handler to be used.
    /// </param>
    public TrucksService(TrucksDepot Depot, Database Database) : base(Depot) {
        _db = Database;
    }
    public async override Task<BatchOperationOutput<Truck_Common>> Create(Truck_Common[] Entities, bool Sync = false) {
        Truck_Common[] successes = [];
        EntityOperationFailure<Truck_Common>[] failures = [];

        foreach (Truck_Common entity in Entities) {
            try {
                Truck_Common attachedEntity = await depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Truck_Common> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Truck_Common> output = new(successes, failures);

        return output;
    }
}
