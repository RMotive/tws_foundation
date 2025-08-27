using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

using Microsoft.EntityFrameworkCore;

using TWS_Business;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Truck_Common"/> based [Service] implementations.
/// </summary>
public interface ITrucksService
    : IService<Truck_Common> {
}

/// <summary>
///     [Service] for <see cref="Address"/> based operations.
/// </summary>
public class TrucksService
    : BService<Truck_Common, TrucksDepot>, ITrucksService {

    private readonly Database _db;

    private static QueryProcessor<Truck_Common> QueryProcessor => (sourceQuery) => {
        sourceQuery = sourceQuery
         .Include(e => e.Internal).ThenInclude(e => e!.Plates)
         .Include(e => e.Internal).ThenInclude(e => e!.Carrier).ThenInclude(e => e!.USDOT)
         .Include(e => e.Internal).ThenInclude(e => e!.SCT)
         .Include(e => e.Internal).ThenInclude(e => e!.Maintenance)
         .Include(e => e.Internal).ThenInclude(e => e!.Insurance)
         .Include(e => e.Internal).ThenInclude(e => e!.Model)
         .Include(e => e.Situation)
         .Include(e => e.Location);
        return sourceQuery;
    };

    /// <summary>
    ///     Creates a new instance of <see cref="TrucksService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Truck_Common"/> based [Depot] handler to be used.
    /// </param>
    /// 

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
    public async override Task<ViewOutput<Truck_Common>> View(QueryInput<Truck_Common, ViewInput<Truck_Common>> input) {
        input.PostProcessor = QueryProcessor;
        return await depot.View(input);
    }


    //public async override Task<UpdateOutput<Truck_Common>> Update(UpdateInput<Truck_Common> input) {

    //    void overwriteProperty<TProperty>(TProperty? original, TProperty? overwritten)
    //        where TProperty : IEntity {
    //        bool needToAdd = original == null && overwritten != null && overwritten.Id == 0;

    //        // Add and asociate a new entity.
    //        if (needToAdd) {
    //            original = overwritten;
    //            if (needToAdd) _db.Entry(original!).State = EntityState.Added;
    //            return;
    //        }

    //        if (overwritten != null) {
    //            // Check if the relationship needs modifications.
    //            if (original != null) {
    //                // validate if the relationship has changed.
    //                if (original.Id != overwritten.Id) {
    //                    _db.Attach(original);
    //                    original = overwritten;
    //                    //_db.Entry(overwritten).State = EntityState.Modified;
    //                    return;
    //                }

    //                // Update existing values.
    //                _db.Entry(original).CurrentValues.SetValues(overwritten);
    //            } else {
    //                // Add relationship with an existing entity.
    //                original = overwritten;
    //                _db.Attach(original);
    //            }
    //        }
    //    }

    //    // Replate common placeholder for the main common entity.
    //    if (input.Entity.Internal != null) {
    //        input.Entity.Internal.Common = input.Entity;
    //    } else {
    //        input.Entity.External!.Common = input.Entity;
    //    }
    //    // Apply the include query processor to the input.
    //    QueryInput<Truck_Common, UpdateInput<Truck_Common>> queryInput = GetOperationInput(input);
    //    queryInput.PostProcessor = QueryProcessor;

    //    Truck_Common overwritten = input.Entity;

    //    if (overwritten.Id == 0) {
    //        return await depot.Update(queryInput);
    //    }

    //    IQueryable<Truck_Common> query = _db.Set<Truck_Common>();
    //    query = queryInput.PostProcessor!(query);

    //    // Check if main entity currently exist in database.
    //    Truck_Common original = await query
    //       .Where(r => r.Id == overwritten.Id)
    //       .FirstOrDefaultAsync() ?? throw new XDepot<Truck_Common>(XDepotSituations.Unfound);

    //    // Preserve a copy before modifications.
    //    Truck_Common oldCopy = original.DeepCopy();

    //    //// Removing unnecesary navigations to avoid tracking issues.
    //    //if (overwritten.Situation != null) original.Situation = null;
    //    //if (overwritten.Location != null) original.Location = null;
    //    //if (overwritten.Internal != null) original.Internal = null;
    //    //if (overwritten.External != null) original.External = null;
    //    //// Detaching not nulleable entities.
    //    //if (overwritten.Status != null) original.Status = null;
    //    _db.ChangeTracker.Clear();
    //    _db.Attach(overwritten);
    //    _db.Entry(overwritten).State = EntityState.Modified;

    //    //_db.Attach(original);

    //    //// Update main model properties.
    //    //EntityEntry previousEntry = _db.Entry(original);
    //    //previousEntry.CurrentValues.SetValues(overwritten);

    //    //// --> Update Location navigation.
    //    ////overwriteProperty(original.Location, overwritten.Location);
    //    //original.Location = overwritten.Location;

    //    //// ---> Update Situation navigation.
    //    ////overwriteProperty(original.Situation, overwritten.Situation);
    //    //if (overwritten.Situation != null && original.Situation?.Id == overwritten.Situation?.Id) _db.Attach(overwritten.Situation!);
    //    //original.Situation = overwritten.Situation;

    //    ////// ---> Update Status navigation.
    //    //original.Status = overwritten.Status;

    //    //original.Internal = overwritten.Internal;


    //    if (original.Internal != null) {
    //        //// ---> Update Carrier navigation.
    //        //overwriteProperty(original.Internal.Carrier, overwritten.Internal?.Carrier);

    //        //// --> Update Model navigation.
    //        //overwriteProperty(original.Internal.Model, overwritten.Internal?.Model);

    //        //// --> Update SCT navigation.
    //        //overwriteProperty(original.Internal.SCT, overwritten.Internal?.SCT);

    //        //// --> Update Maintenance navigation.
    //        //overwriteProperty(original.Internal.Maintenance, overwritten.Internal?.Maintenance);

    //        //// --> Update Insurance navigation.
    //        //overwriteProperty(original.Internal.Insurance, overwritten.Internal?.Insurance);

    //        // --> Plates
    //        //if (overwritten.Internal?.Plates != null && original.Internal?.Plates != null) {
    //        //    // Perform iterations to find new items and modify the current items.
    //        //    List<Plate> plates = [.. overwritten.Internal.Plates];
    //        //    List<Plate> originalPlates = [.. original.Internal.Plates];

    //        //    // Check if the plates lists has the same order.
    //        //    if (plates.First().Id != originalPlates.First().Id) {
    //        //        //Ordererig the lists to avoid wrong keys exceptions.
    //        //        plates = [.. plates.OrderBy(plate => plate.Id)];
    //        //        originalPlates = [.. originalPlates.OrderBy(plate => plate.Id)];
    //        //    }

    //        //    // Search new items to add in the given trucks record.
    //        //    for (int i = 0; i < plates.Count; i++) {
    //        //        Plate plate = plates[i];
    //        //        //Add new plate.
    //        //        if (plate.Id <= 0) {
    //        //            // Getting the item type to add.
    //        //            Type itemType = plate.GetType();
    //        //            // Getting the Add method from Icollection.
    //        //            var addMethod = original.Internal.Plates.GetType().GetMethod("Add", [itemType]);
    //        //            // Adding the new item to Icollection.
    //        //            _ = (addMethod?.Invoke(original.Internal.Plates, [plate]));
    //        //        } else if (plate.Id > 0) {
    //        //            //Modify an existent plate
    //        //            //_db.Entry(originalPlates[i]).CurrentValues.SetValues(plate);
    //        //            originalPlates[i] = plate;
    //        //        }
    //        //    }
    //        //}
    //    }

    //    await _db.SaveChangesAsync();

    //    //Disposer?.Push(overwritten);
    //    // Get the lastest record data from database.
    //    Truck_Common? lastest = await query
    //       .Where(r => r.Id == overwritten.Id)
    //       .FirstOrDefaultAsync();

    //    return new UpdateOutput<Truck_Common> {
    //        Original = oldCopy,
    //        Updated = lastest ?? overwritten,
    //    };
    //}
}
