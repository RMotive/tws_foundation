using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Utilitites;

namespace TWS_Business.Depots;

public class BCommonDepot<TInternal, TExternal, TCommon>
    : BDepot<Database, TCommon>
    where TCommon : TWSScopeCommonEntity<TInternal, TExternal>, new() 
    where TInternal : TWSScopeEntity<TCommon> 
    where TExternal : TWSScopeEntity<TCommon> {

    public BCommonDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }


    public override async Task<TCommon> Create(TCommon entity) {
        entity.EvaluateWrite();

        TInternal? internalRelation = entity.Internal;
        TExternal? externalRelation = entity.External;

        entity.Internal = null;
        entity.External = null;

        entity = DatabaseUtilities.SanitizeEntity(Database, entity);
        
        await Set.AddAsync(entity);

        if(internalRelation != null) {
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
        externalRelation.Common = entity;
        externalRelation.Timestamp = DateTime.UtcNow;

        await Database.Set<TExternal>().AddAsync(externalRelation);

        entity.External = externalRelation;
        return entity;
    }
}
