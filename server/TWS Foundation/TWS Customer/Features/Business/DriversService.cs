using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

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

    private  QueryProcessor<Driver_Common> queryProcessor => (sourceQuery) => {
        sourceQuery = sourceQuery.Include(e => e.Internal!.Employee.Approach).Include(e => e.Internal!.Employee.Address);
        return sourceQuery;
    };

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
                Driver_Common attachedEntity = await depot.Store(entity);
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
        input.PostProcessor = queryProcessor;
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
        // Apply the include query processor to the input.
        QueryInput<Driver_Common, UpdateInput<Driver_Common>> queryInput = GetOperationInput(input);
        queryInput.PostProcessor = queryProcessor;

        return await _depot.Update(queryInput);
    }


}
