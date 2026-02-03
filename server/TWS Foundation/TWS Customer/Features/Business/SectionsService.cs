using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Depots.Models;

using CSM_Foundation.Product;

using Microsoft.EntityFrameworkCore;

using TWS_Business;
using TWS_Business.Depots.Directories;
using TWS_Business.Entities;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Section"/> based [Service] implementations.
/// </summary>
public interface ISectionsService
    : IService<Section> {
}

/// <summary>
///     [Service] for <see cref="Section"/> based operations.
/// </summary>
public class SectionsService
    : BService<Section, SectionsDepot>, ISectionsService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="SectionsService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Section"/> based [Depot] handler to be used.
    /// </param>
    public SectionsService(SectionsDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }

    private static QueryProcessor<Section> QueryProcessor => (sourceQuery) => {
        sourceQuery = sourceQuery
         .Include(e => e.Status)
         .Include(e => e.Yard)
         .Include(e => e.Resource);
        return sourceQuery;
    };

    public async override Task<ViewOutput<Section>> View(QueryInput<Section, ViewInput<Section>> input) {
        input.PostProcessor = QueryProcessor;
        return await depot.View(input);
    }
}
