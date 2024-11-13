using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="YardLog"/> dataDatabases entity mirror.
/// </summary>
public class YardLogsDepot
    : BDepot<TWSBusinessDatabase, YardLog> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="YardLog"/>.
    /// </summary>
    public YardLogsDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public YardLogsDepot()
        : base(new(), null) {
    }


    public Task<SetViewOut<YardLog>> ViewInventory(SetViewOptions<YardLog> Options) {
        IQueryable<YardLog> entries = Set

            .OrderBy(i => i.Timestamp)
            .GroupBy(i => new { i.Trailer, i.TrailerExternal })
            .Where(i => (i.Key.Trailer != null || i.Key.TrailerExternal != null) && i.OrderBy(i => i.Timestamp).Last().Entry)
            .Select(i => i.OrderBy(i => i.Timestamp).Last());

        return Processing(
            Options,
            Include: (query) => {
                return query
                .Include(i => i.TrailerNavigation)
                    .ThenInclude(i => i!.TrailerCommonNavigation)
                .Include(i => i.TrailerNavigation)
                    .ThenInclude(i => i!.CarrierNavigation)
                .Include(i => i.TrailerNavigation)
                    .ThenInclude(i => i!.Plates)
                .Include(i => i.TrailerExternalNavigation)
                    .ThenInclude(i => i!.TrailerCommonNavigation)
                .Include(i => i.SectionNavigation)
                    .ThenInclude(i => i!.LocationNavigation);
            },
            AfterFilters: (query) => {
                return query
                .OrderBy(i => i.Timestamp)
                .GroupBy(i => new { i.Trailer, i.TrailerExternal })
                .Where(i => (i.Key.Trailer != null || i.Key.TrailerExternal != null) && i.OrderBy(i => i.Timestamp).Last().Entry)
                .Select(i => i.OrderBy(i => i.Timestamp).Last())
                .ToList()
                .OrderBy(i => i.Timestamp)
                .AsQueryable();        }
        );
    }
}
