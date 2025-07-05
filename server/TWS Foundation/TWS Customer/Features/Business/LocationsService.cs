using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Location"/> based [Service] implementations.
/// </summary>
public interface ILocationsService
    : IService<Location> {
}

/// <summary>
///     [Service] for <see cref="Location"/> based operations.
/// </summary>
public class LocationsService
    : BService<Location, LocationsDepot>, ILocationsService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="LocationsService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Location"/> based [Depot] handler to be used.
    /// </param>
    public LocationsService(LocationsDepot Depot, Database Database) : base(Depot) { 
        this._db = Database;
    }

    public async override Task<BatchOperationOutput<Location>> Create(Location[] Entities, bool Sync = false) {
        Location[] successes = [];
        EntityOperationFailure<Location>[] failures = [];

        foreach (Location entity in Entities) {
            try {
                Location attachedEntity = await _depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Location> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Location> output = new(successes, failures);

        return output;
    }
           
}
