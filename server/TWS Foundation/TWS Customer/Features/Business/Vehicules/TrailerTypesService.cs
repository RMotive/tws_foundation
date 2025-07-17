using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Customer.Features.Business.Vehicules;

/// <summary>
///     [Interface] for <see cref="Trailer_Type"/> based [Service] implementations.
/// </summary>
public interface ITrailerTypesService
    : IService<Trailer_Type> {
}

/// <summary>
///     [Service] for <see cref="Trailer_Type"/> based operations.
/// </summary>
public class TrailerTypesService
    : BService<Trailer_Type, TrailerTypesDepot>, ITrailerTypesService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="TrailerTypesService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Trailer_Type"/> based [Depot] handler to be used.
    /// </param>
    public TrailerTypesService(TrailerTypesDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }

    public async override Task<BatchOperationOutput<Trailer_Type>> Create(Trailer_Type[] Entities, bool Sync = false) {
        Trailer_Type[] successes = [];
        EntityOperationFailure<Trailer_Type>[] failures = [];

        foreach (Trailer_Type entity in Entities) {
            try {
                Trailer_Type attachedEntity = await _depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Trailer_Type> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Trailer_Type> output = new(successes, failures);

        return output;
    }
}
