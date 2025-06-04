using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Database.Utilitites;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Depots;

public class BCommonDepot<TInternal, TExternal, TCommon>
    : BDepot<Database, TCommon>
    where TCommon : CommonEntity<TInternal, TExternal>, new()
    where TInternal : CommonEntityEdge<TCommon>
    where TExternal : CommonEntityEdge<TCommon> {

    public BCommonDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }

    public override async Task<TCommon> Create(TCommon entity) {
        entity.EvaluateWrite();

        TInternal? internalRelation = entity.Internal;
        TExternal? externalRelation = entity.External;

        entity.Internal = null;
        entity.External = null;

        entity = DatabaseUtilities.SanitizeEntity(Database, entity);

        await Set.AddAsync(entity);

        if (internalRelation != null) {
            internalRelation.EvaluateWrite();

            internalRelation = DatabaseUtilities.SanitizeEntity(Database, internalRelation);
            internalRelation.Common = entity;
            internalRelation.Timestamp = DateTime.UtcNow;

            await Database.Set<TInternal>().AddAsync(internalRelation);

            entity.Internal = internalRelation;
            return entity;
        }

        externalRelation!.EvaluateWrite();

        externalRelation = DatabaseUtilities.SanitizeEntity(Database, externalRelation);
        externalRelation.Timestamp = DateTime.UtcNow;
        externalRelation.Common = entity;

        await Database.Set<TExternal>().AddAsync(externalRelation);

        entity.External = externalRelation;
        return entity;
    }

    public async Task<TCommon> DeleteCommon(TCommon Entity) {
        if (Entity.Internal != null) {
            Database.Set<TInternal>().Remove(Entity.Internal!);
        } else {
            Database.Set<TExternal>().Remove(Entity.External!);
        }

        Set.Remove(Entity);
        await Database.SaveChangesAsync();
        return Entity;
    }

    public Task<BatchOperationOutput<TCommon>> DeleteCommon(OperationInput<TCommon, BatchOperationInput<TCommon>> input) {
        BatchOperationInput<TCommon> parameters = input.Parameters;

        IQueryable<TCommon> query = Set;
        query = ValidateProcessor(query, input.PreOperation);
        query = query.AsTracking()
            .Where(parameters.Filter)
            .Include(e => e.Internal)
            .Include(e => e.External);

        query = ValidateProcessor(query, input.PostOperation);

        List<TCommon> successes = [];
        List<EntityOperationFailure<TCommon>> failures = [];
        foreach (TCommon entity in query) {
            try {
                
                if (entity.Internal != null) {
                    Database.Set<TInternal>().Remove(entity.Internal);
                } else {
                    Database.Set<TExternal>().Remove(entity.External!);
                }

                Set.Remove(entity);

                successes.Add(entity);
            } catch (Exception exception) {
                failures.Add(
                        new EntityOperationFailure<TCommon>(entity, exception)
                    );
            }
        }

        return Task.FromResult(
                new BatchOperationOutput<TCommon>([.. successes], [.. failures])
            );
    }
}
