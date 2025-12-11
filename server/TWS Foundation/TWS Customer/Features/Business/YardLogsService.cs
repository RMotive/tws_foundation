using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Product;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots.Vehicles.Control;
using TWS_Business.Entities;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="YardLog"/> based [Service] implementations. 
/// </summary>
public interface IYardLogsService
    : IService<YardLog> {

    /// <summary>
    ///     Generates a Inventory View of <see cref="YardLog"/>, filtered by trailers.
    /// </summary>
    /// <param name="input">
    ///     <see cref="QueryInput{TEntity, TParameters}"/> data.
    /// </param>
    /// <returns>
    ///     <see cref="ViewOutput{TEntity}"/> data.
    /// </returns>
    Task<ViewOutput<YardLog>> InventoryTrailerView(QueryInput<YardLog, ViewInput<YardLog>> input);
}

/// <summary>
///     [Service] native implementation for <see cref="YardLog"/> based operations.
/// </summary>
public class YardLogsService
    : BService<YardLog, IYardLogsDepot>, IYardLogsService {
    private static QueryProcessor<YardLog> QueryProcessor => (sourceQuery) => {
        sourceQuery = sourceQuery
            .Include(e => e.Resources)
            .Include(e => e.Guard).ThenInclude(e => e.Approach)
            .Include(e => e.Guard).ThenInclude(e => e.Address)
            .Include(e => e.Section).ThenInclude(e => e.Resource)
            .Include(e => e.LoadType)
            .Include(e => e.Driver)
            .Include(e => e.Truck)
            .Include(e => e.Trailer);


        //.Include(e => e.Truck).ThenInclude(e => e!.Location).ThenInclude(e => e!.Resource)
        //.Include(e => e.Truck).ThenInclude(e => e!.Situation)
        //.Include(e => e.Truck).ThenInclude(e => e!.Internal).ThenInclude(e => e!.SCT)
        //.Include(e => e.Truck).ThenInclude(e => e!.Internal).ThenInclude(e => e!.Maintenance)
        //.Include(e => e.Truck).ThenInclude(e => e!.Internal).ThenInclude(e => e!.Insurance)
        //.Include(e => e.Truck).ThenInclude(e => e!.External)

        //.Include(e => e.Trailer).ThenInclude(e => e!.Type)
        //.Include(e => e.Trailer).ThenInclude(e => e!.Situation)
        //.Include(e => e.Trailer).ThenInclude(e => e!.Location).ThenInclude(e => e!.Resource)
        //.Include(e => e.Trailer).ThenInclude(e => e!.Internal).ThenInclude(e => e!.SCT)
        //.Include(e => e.Trailer).ThenInclude(e => e!.Internal).ThenInclude(e => e!.Model)
        //.Include(e => e.Trailer).ThenInclude(e => e!.Internal).ThenInclude(e => e!.Maintenance)
        //.Include(e => e.Trailer).ThenInclude(e => e!.External)

        //.Include(e => e.Driver).ThenInclude(e => e!.Internal).ThenInclude(e => e!.Employee).ThenInclude(e => e.Address)
        //.Include(e => e.Driver).ThenInclude(e => e!.Internal).ThenInclude(e => e!.Employee).ThenInclude(e => e.Approach)
        //.Include(e => e.Driver).ThenInclude(e => e!.External);

        return sourceQuery;
    };

    /// <summary>
    ///     Creates a new <see cref="YardLogsService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="YardLog"/> based <see cref="IDepot{TEntity}"/> handler to be used
    /// </param>
    public YardLogsService(IYardLogsDepot Depot) : base(Depot) { }
    public async override Task<ViewOutput<YardLog>> View(QueryInput<YardLog, ViewInput<YardLog>> input) {
        input.PostProcessor = QueryProcessor;
        return await depot.View(input);
    }

    public async Task<ViewOutput<YardLog>> InventoryTrailerView(QueryInput<YardLog, ViewInput<YardLog>> input) {
        input.PreProcessor = (query) => {
            return query
            .Include(e => e.Guard).ThenInclude(e => e.Approach)
            .Include(e => e.Guard).ThenInclude(e => e.Address)
            .Include(e => e.Section).ThenInclude(e => e.Resource)
            .Include(e => e.LoadType)
            .Include(e => e.Driver)
            .Include(e => e.Truck)
            .Include(e => e.Trailer);
        };

        input.PostProcessor = (query) => {
            //return query
            //.Where(i => i.Trailer != null)
            //.GroupBy(i => i.Trailer!.Id)
            //.Select(i => i.OrderByDescending(y => y.Timestamp).First())
            //.OrderByDescending(i => i.Timestamp)
            //.AsQueryable();

            // Get the last entry for every trailer in yardlogs.
            var lastPerTrailer = query
                .Where(i => i.Trailer != null)
                .GroupBy(i => i.Trailer!.Id)
                .Select(g => new { TrailerId = g.Key, MaxTimestamp = g.Max(x => x.Timestamp) });

            // Join the previous trailers results.
            var lastLogsQuery = from l in lastPerTrailer
                                join y in query.Where(i => i.Trailer != null)
                                  on new { TrailerId = l.TrailerId, Timestamp = l.MaxTimestamp }
                                  equals new { TrailerId = y.Trailer!.Id, Timestamp = y.Timestamp }
                                select y;

            return lastLogsQuery
                .OrderByDescending(y => y.Timestamp)
                .AsQueryable();

        };

        return await depot.View(input);
    }

}
