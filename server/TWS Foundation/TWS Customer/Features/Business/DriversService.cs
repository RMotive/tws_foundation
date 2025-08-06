using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using Microsoft.EntityFrameworkCore;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Entities.Drivers;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Driver_Common"/> based [Service] implementations.
/// </summary>
public interface IDriversService
    : IService<Driver_Common> {
}


/// <summary>
///     [Service] for <see cref="Address"/> based operations.
/// </summary>
public class DriversService
    : BService<Driver_Common, DriversDepot>, IDriversService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="DriversService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Driver_Common"/> based [Depot] handler to be used.
    /// </param>
    public DriversService(DriversDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }

    public async override Task<BatchOperationOutput<Driver_Common>> Create(Driver_Common[] Entities, bool Sync = false) {
        Driver_Common[] successes = [];
        EntityOperationFailure<Driver_Common>[] failures = [];

        foreach (Driver_Common entity in Entities) {
            try {
                Driver_Common attachedEntity = await _depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Driver_Common> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Driver_Common> output = new(successes, failures);

        return output;
    }

    public async override Task<ViewOutput<Driver_Common>> View(QueryInput<Driver_Common, ViewInput<Driver_Common>> input) {
        input.PostProcessor = (sourceQuery) => {
            sourceQuery = sourceQuery.Include(e => e.Internal!.Employee.Approach).Include(e => e.Internal!.Employee.Address);
            return sourceQuery;
        };
        return await _depot.View(input);
    }

    public async override Task<UpdateOutput<Driver_Common>> Update(UpdateInput<Driver_Common> input) {
        // Check if the trailer currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        Driver_Common overwritte = input.Entity;

        if (input.Entity.Internal != null) {
            input.Entity.Internal.Common = input.Entity;
        } else {
            input.Entity.External!.Common = input.Entity;
        }

        return await _depot.Update(
               GetOperationInput(input)
           );

        //IQueryable<Driver_Common> processedQuery = _depot.ProcessQuery(
        //    GetOperationInput(input),
        //    (sourceQuery) => sourceQuery
        //);

        //Driver_Common? old = await processedQuery
        //    .Where(i => i.Id == input.Entity.Id)
        //    .FirstOrDefaultAsync();

        //// If trailer not exist in database, then use the generic update method.
        //if (old == null) {
        //    return await _depot.Update(
        //        GetOperationInput(input)
        //    );
        //}
        //// Save a deep copy before changes.
        //Driver_Common previousDeepCopy = old.DeepCopy();

        //_db.Attach(old);

        //// Update the main model properties.
        //EntityEntry oldEntry = _db.Entry(old);
        //oldEntry.CurrentValues.SetValues(overwritte);

        //// ---> Update DriverCommons navigation
        //if (overwritte.Internal != null) {
        //    _db.Entry(old.Internal!).CurrentValues.SetValues(overwritte.Internal);
        //    // --> Employee navigations
        //    _db.Entry(old.Internal!.Employee).CurrentValues.SetValues(overwritte.Internal.Employee);
        //    _db.Entry(old.Internal!.Employee).CurrentValues.SetValues(overwritte.Internal.Employee);

        //}

        //// ---> Update Employee navigation
        //if (overwritte.External != null) {
        //   old.External = overwritte.External;
        //}

        //await _db.SaveChangesAsync();

        //return new UpdateOutput<Driver_Common> {
        //    Original = previousDeepCopy,
        //    Updated = overwritte,
        //};

    }


}
