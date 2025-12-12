using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

using Microsoft.EntityFrameworkCore;

using TWS_Business;
using TWS_Business.Depots.Directories;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trucks;

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

    public async override Task<BatchOperationOutput<Section>> Create(Section[] Entities, bool Sync = false) {
        Section[] successes = [];
        EntityOperationFailure<Section>[] failures = [];

        foreach (Section entity in Entities) {
            try {
                Section attachedEntity = await depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Section> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Section> output = new(successes, failures);

        return output;
    }

    public async override Task<ViewOutput<Section>> View(QueryInput<Section, ViewInput<Section>> input) {
        input.PostProcessor = QueryProcessor;
        return await depot.View(input);
    }
}
