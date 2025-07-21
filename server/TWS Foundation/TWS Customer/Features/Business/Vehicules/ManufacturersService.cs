using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

using TWS_Business;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

namespace TWS_Customer.Features.Business.Vehicules;

/// <summary>
///     [Interface] for <see cref="Manufacturer"/> based [Service] implementations.
/// </summary>
public interface IManufacturersService
    : IService<Manufacturer> {
}

/// <summary>
///     [Service] for <see cref="Manufacturer"/> based operations.
/// </summary>
public class ManufacturersService
    : BService<Manufacturer, ManufacturersDepot>, IManufacturersService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="ManufacturersService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Manufacturer"/> based [Depot] handler to be used.
    /// </param>
    public ManufacturersService(ManufacturersDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }

    public async override Task<BatchOperationOutput<Manufacturer>> Create(Manufacturer[] Entities, bool Sync = false) {
        Manufacturer[] successes = [];
        EntityOperationFailure<Manufacturer>[] failures = [];

        foreach (Manufacturer entity in Entities) {
            try {
                Manufacturer attachedEntity = await depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Manufacturer> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Manufacturer> output = new(successes, failures);

        return output;
    }
}
