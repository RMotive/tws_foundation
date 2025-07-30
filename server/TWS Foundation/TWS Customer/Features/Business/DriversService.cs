using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;

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

    public async override Task<UpdateOutput<Driver_Common>> Update(UpdateInput<Driver_Common> input) {
        if(input.Entity.Internal != null) {
            input.Entity.Internal.Common = input.Entity;
        } else {
            input.Entity.External!.Common = input.Entity;
        }
        return await _depot.Update(
            GetOperationInput(input)
        );
    }


}
