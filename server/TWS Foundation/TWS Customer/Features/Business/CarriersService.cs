using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

using TWS_Business;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Carrier"/> based [Service] implementations.
/// </summary>
public interface ICarriersService
    : IService<Carrier> {
}

/// <summary>
///     [Service] for <see cref="Carrier"/> based operations.
/// </summary>
public class CarriersService
    : BService<Carrier, CarriersDepot>, ICarriersService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="CarriersService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Carrier"/> based [Depot] handler to be used.
    /// </param>
    public CarriersService(CarriersDepot Depot, Database database) : base(Depot) {
        this._db = database;
    }

    public async override Task<BatchOperationOutput<Carrier>> Create(Carrier[] Entities, bool Sync = false) {
        Carrier[] successes = [];
        EntityOperationFailure<Carrier>[] failures = [];

        foreach (Carrier entity in Entities) {
            try {
                Carrier attachedEntity = await depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Carrier> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Carrier> output = new(successes, failures);

        return output;
    }
}
