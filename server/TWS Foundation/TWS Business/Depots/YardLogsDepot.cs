﻿using CSM_Foundation.Database.Bases;
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
    public YardLogsDepot() 
        : base(new(), null) {
    }


    public Task<SetViewOut<YardLog>> ViewInventory(SetViewOptions<YardLog> Options) {
        IQueryable<YardLog> entries = Set
            .Include(i => i.TruckNavigation)
            .Include(i => i.TruckExternalNavigation)
            .OrderBy(i => i.Timestamp)
            .GroupBy(i => new { i.Truck, i.TruckExternal })
            .Where(i => (i.Key.Truck != null || i.Key.Truck != null) && i.OrderBy(i => i.Timestamp).Last().Entry)
            .Select(i => i.OrderBy(i => i.Timestamp).Last());

        return Processing(Options, entries);
    }
}
