using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Customer.Features.Business.Vehicules;

/// <summary>
///     [Interface] for <see cref="Trailer_Class"/> based [Service] implementations.
/// </summary>
public interface ITrailerClassesService
    : IService<Trailer_Class> {
}

/// <summary>
///     [Service] for <see cref="Trailer_Class"/> based operations.
/// </summary>
/// </summary>
public class TrailerClassesService
    : BService<Trailer_Class, TrailerClassesDepot>, ITrailerClassesService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="TrailerclasssService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Trailer_Class"/> based [Depot] handler to be used.
    /// </param>
    public TrailerClassesService(TrailerClassesDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }
    public async override Task<BatchOperationOutput<Trailer_Class>> Create(Trailer_Class[] Entities, bool Sync = false) {
        Trailer_Class[] successes = [];
        EntityOperationFailure<Trailer_Class>[] failures = [];

        foreach (Trailer_Class entity in Entities) {
            try {
                Trailer_Class attachedEntity = await _depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Trailer_Class> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Trailer_Class> output = new(successes, failures);

        return output;
    }

}
