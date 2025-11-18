using System.Numerics;

using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

using Microsoft.EntityFrameworkCore;

using TWS_Business;
using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Customer.Features.Business.Vehicules;

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

    private static QueryProcessor<Trailer_Common> QueryProcessor => (sourceQuery) => {
        sourceQuery = sourceQuery
            .Include(e => e.Situation)
            .Include(e => e.Location)
            .Include(e => e.Type)
            .Include(e => e.Internal).ThenInclude(e => e!.Plates)
            .Include(e => e.Internal).ThenInclude(e => e!.Carrier).ThenInclude(e => e!.USDOT)
            .Include(e => e.Internal).ThenInclude(e => e!.SCT)
            .Include(e => e.Internal).ThenInclude(e => e!.Maintenance)
            .Include(e => e.Internal).ThenInclude(e => e!.Model)
            .Include(e => e.External);

        return sourceQuery;
    };

    /// <summary>
    ///     Creates a new instance of <see cref="TrailersService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Truck_Common"/> based [Depot] handler to be used.
    /// </param>
    public TrailersService(TrailersDepot Depot, Database Database) : base(Depot) {
        _db = Database;
    }

    public async override Task<ViewOutput<Trailer_Common>> View(QueryInput<Trailer_Common, ViewInput<Trailer_Common>> input) {
        input.PostProcessor = QueryProcessor;
        return await depot.View(input);
    }
    public async override Task<BatchOperationOutput<Trailer_Common>> Create(Trailer_Common[] Entities, bool Sync = false) {
        Trailer_Common[] successes = [];
        EntityOperationFailure<Trailer_Common>[] failures = [];

        foreach (Trailer_Common entity in Entities) {
            try {
                Dictionary<BigInteger, Status> statusCache = [];
                Dictionary<BigInteger, Location> locationCache = [];
                Dictionary<BigInteger, Situation> situationCache = [];
                Dictionary<BigInteger, VehiculeModel> vehiculeCache = [];
                Dictionary<BigInteger, Manufacturer> manufacturerCache = [];
                Dictionary<BigInteger, Carrier> carrierCache = [];


                Status? activeStatus = await _db.Statuses.FirstOrDefaultAsync(e => e.Reference == Constants.References.statusActive);

                if (entity.Location != null) {
                    entity.Location = await depot.GetEntityCache(entity.Location, locationCache);
                }

                if (entity.Situation != null) {
                    entity.Situation = await depot.GetEntityCache(entity.Situation, situationCache);
                }

                if (activeStatus != null) {
                    statusCache[activeStatus.Id] = activeStatus;
                    entity.Status = await depot.GetEntityCache(entity.Status, statusCache);

                    if (entity.Internal != null) {
                        entity.Internal.SCT?.Status = activeStatus;
                        entity.Internal.Maintenance?.Status = activeStatus;
                        entity.Internal.Carrier = await depot.GetEntityCache(entity.Internal.Carrier, carrierCache);

                        if (entity.Internal?.Model?.Id > 0) {
                            entity.Internal.Model = await depot.GetEntityCache(entity.Internal.Model, vehiculeCache);
                        } else if (entity.Internal?.Model != null){
                            entity.Internal?.Model.Status = activeStatus;
                            entity.Internal?.Model.Manufacturer = await depot.GetEntityCache(entity.Internal.Model.Manufacturer, manufacturerCache);
                        }

                        foreach (Plate plate in entity.Internal?.Plates ?? []) {
                            plate.Status = activeStatus;
                        }
                    }
                }
                entity.Internal?.Common = entity;
                entity.External?.Common = entity;
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
