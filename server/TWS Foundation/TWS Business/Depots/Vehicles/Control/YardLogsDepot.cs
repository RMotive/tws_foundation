using CSM_Database_Core.Core.Errors;
using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Depots.Models;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots.Vehicles.Control;

/// <summary>
///     [Interface] for <see cref="YardLog"/> based 
/// </summary>
public interface IYardLogsDepot
    : IDepot<YardLog> {
}

/// <summary>
///     [Depot] implementation for <see cref="YardLog"/> based entity handler.
/// </summary>
public class YardLogsDepot
    : DepotBase<Database, YardLog>, IYardLogsDepot {

    readonly CSM_Security.Database _securityDb;

    /// <summary>
    ///     Creates a new <see cref="YardLogsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    /// 

    public YardLogsDepot(Database Database, CSM_Security.Database SecurityDatabase, IDisposer<IEntity>? Disposer) : base(Database, Disposer) { 
        _securityDb = SecurityDatabase;
    }

    public async override Task<YardLog> Create(YardLog entity) {
        HashSet<IEntity> addEntities = [];
        //bool truckRootChecked = false;
        //bool trailerRootChecked = false;
        //bool DriverRootChecked = false;

        entity.EvaluateWrite();

        //if (entity.Truck != null) StoreNestedCommonEntities<Truck_Common, Truck, TruckExternal>(entity.Truck, entity.Truck, addEntities, truckRootChecked);
        //if (entity.Trailer != null) StoreNestedCommonEntities<Trailer_Common, Trailer, TrailerExternal>(entity.Trailer, entity.Trailer, addEntities, trailerRootChecked);
        //if (entity.Driver != null) StoreNestedCommonEntities<Driver_Common, Driver, DriverExternal>(entity.Driver, entity.Driver, addEntities, DriverRootChecked);

        //StoreNestedEntities(entity, addEntities);

        foreach (IEntity currentEntity in addEntities.Reverse()) {
            if (currentEntity.Id == 0) {
                _db.Add(currentEntity);
                _disposer?.Push(currentEntity);
            }
        }

        await _db.SaveChangesAsync();

        return entity;
    }

    public async override Task<BatchOperationOutput<YardLog>> Create(ICollection<YardLog> entities, bool sync = false) {
        YardLog[] attached = [];
        EntityError<YardLog>[] failures = [];


        foreach (YardLog entity in entities) {
            try {
                YardLog attachedEntity = await Create(entity);
                attached = [.. attached, attachedEntity];
            } catch (Exception excep) {
                if (sync) {
                    throw;
                }

                EntityError<YardLog> fail = new(EntityErrorEvents.CREATE_FAILED, entity, excep);
                failures = [.. failures, fail];
            }
        }

        return new(attached, failures);
    }
}
