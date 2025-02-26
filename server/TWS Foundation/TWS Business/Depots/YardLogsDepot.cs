using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="YardLog"/> dataDatabases entity mirror.
/// </summary>
public class YardLogsDepot
    : BDepot<BusinessDatabase, YardLog> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="YardLog"/>.
    /// </summary>
    public YardLogsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public YardLogsDepot()
        : base(new(), null) {
    }


    public Task<SetViewOut<YardLog>> ViewInventory(SetViewOptions<YardLog> Options) {
        return Processing(
            Options,
            (query) => {
                return query
                    .OrderBy(i => i.Timestamp)
                    .GroupBy(
                        i => 
                            new { 
                                i.Trailer!.Internal, 
                                i.Trailer.External 
                            }
                    )
                    .Where(
                        i => 
                            (
                                i.Key.Internal != null 
                                || i.Key.External != null
                            ) 
                            && i.OrderBy(i => i.Timestamp).Last().Entry
                    )
                    .Select(
                        i => i.OrderBy(i => i.Timestamp).Last()
                    )
                    .ToList()
                    .OrderByDescending(y => y.Timestamp)
                    .AsQueryable();
            }
        );
    }
}
 