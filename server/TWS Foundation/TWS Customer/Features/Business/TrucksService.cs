using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

using Microsoft.EntityFrameworkCore;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Drivers;
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
    /// 
    private static QueryProcessor<Truck_Common> QueryProcessor => (sourceQuery) => {
        sourceQuery = sourceQuery
        .Include(e => e.Situation)
        .Include(e => e.Location)
        .Include(e => e.Internal!.Carrier.USDOT)
        .Include(e => e.Internal!.SCT)
        .Include(e => e.Internal!.Maintenance)
        .Include(e => e.Internal!.Insurance);


        return sourceQuery;
    };
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

    public async override Task<UpdateOutput<Truck_Common>> Update(UpdateInput<Truck_Common> input) {
        // Replate common placeholder for the main common entity.
        if (input.Entity.Internal != null) {
            input.Entity.Internal.Common = input.Entity;
        } else {
            input.Entity.External!.Common = input.Entity;
        }
        // Apply the include query processor to the input.
        QueryInput<Truck_Common, UpdateInput<Truck_Common>> queryInput = GetOperationInput(input);
        queryInput.PostProcessor = QueryProcessor;

        return await depot.Update(queryInput);
    }
}
