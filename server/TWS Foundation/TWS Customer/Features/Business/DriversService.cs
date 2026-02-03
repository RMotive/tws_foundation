using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Depots.Models;

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

    private static QueryProcessor<Driver_Common> QueryProcessor => (sourceQuery) => {
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

    public async override Task<ViewOutput<Driver_Common>> View(QueryInput<Driver_Common, ViewInput<Driver_Common>> input) {
        input.PostProcessor = QueryProcessor;
        return await depot.View(input);
    }

    public async override Task<UpdateOutput<Driver_Common>> Update(UpdateInput<Driver_Common> input) {
        // Replate common placeholder for the main common entity.
        if (input.Entity.Internal != null) {
            input.Entity.Internal.Bridge = input.Entity;
        } else {
            input.Entity.External!.Bridge = input.Entity;
        }
        // Apply the include query processor to the input.
        QueryInput<Driver_Common, UpdateInput<Driver_Common>> queryInput = GetOperationInput(input);
        queryInput.PostProcessor = QueryProcessor;

        return await depot.Update(queryInput);
    }


}
