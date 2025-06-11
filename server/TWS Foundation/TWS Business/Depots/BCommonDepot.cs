using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Utilitites;

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

        entity = DatabaseUtilities.SanitizeEntity(_db, entity);
        
        await _dbSet.AddAsync(entity);

        if(internalRelation != null) {
            internalRelation.EvaluateWrite();

            internalRelation = DatabaseUtilities.SanitizeEntity(_db, internalRelation);
            internalRelation.Common = entity;
            internalRelation.Timestamp = DateTime.UtcNow;

            await _db.Set<TInternal>().AddAsync(internalRelation);

            entity.Internal = internalRelation;
            return entity;
        }


        externalRelation!.EvaluateWrite();

        externalRelation = DatabaseUtilities.SanitizeEntity(_db, externalRelation);
        externalRelation.Common = entity;
        externalRelation.Timestamp = DateTime.UtcNow;

        await _db.Set<TExternal>().AddAsync(externalRelation);

        entity.External = externalRelation;
        return entity;
    }
}
