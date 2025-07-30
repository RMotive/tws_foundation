using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

using TWS_Business;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Truck_Common"/> based [Service] implementations.
/// </summary>
public interface ITrailersService
    : IService<Trailer_Common> {
}

/// <summary>
///     [Service] for <see cref="Address"/> based operations.
/// </summary>
public class TrailersService
    : BService<Trailer_Common, TrailersDepot>, ITrailersService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="TrailersService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Truck_Common"/> based [Depot] handler to be used.
    /// </param>
    public TrailersService(TrailersDepot Depot, Database Database) : base(Depot) { 
        _db = Database;
    }

    public async override Task<BatchOperationOutput<Trailer_Common>> Create(Trailer_Common[] Entities, bool Sync = false) {
        Trailer_Common[] successes = [];
        EntityOperationFailure<Trailer_Common>[] failures = [];

        foreach (Trailer_Common entity in Entities) {
            try {
                Trailer_Common attachedEntity = await depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Trailer_Common> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Trailer_Common> output = new(successes, failures);

        return output;
    }
}
