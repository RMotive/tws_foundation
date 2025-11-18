using System.Runtime.Intrinsics.Arm;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

using static Azure.Core.HttpHeader;

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
    : BDepot<Database, YardLog>, IYardLogsDepot {

    /// <summary>
    ///     Creates a new <see cref="YardLogsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public YardLogsDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }

    public async override Task<YardLog> Create(YardLog entity) {
        HashSet<IEntity> addEntities = [];
        bool truckRootChecked = false;
        bool trailerRootChecked = false;
        bool DriverRootChecked = false;

        entity.EvaluateWrite();

        if (entity.Truck != null) StoreNestedCommonEntities<Truck_Common, Truck, TruckExternal>(entity.Truck, entity.Truck, addEntities, truckRootChecked);
        if (entity.Trailer != null) StoreNestedCommonEntities<Trailer_Common, Trailer, TrailerExternal>(entity.Trailer, entity.Trailer, addEntities, trailerRootChecked);
        if (entity.Driver != null) StoreNestedCommonEntities<Driver_Common, Driver, DriverExternal>(entity.Driver, entity.Driver, addEntities, DriverRootChecked);

        StoreNestedEntities(entity, addEntities);
        
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
        EntityOperationFailure<YardLog>[] failures = [];
   

        foreach (YardLog entity in entities) {
            try {
                YardLog attachedEntity = await Create(entity);
                attached = [.. attached, attachedEntity];
            } catch (Exception excep) {
                if (sync) {
                    throw;
                }

                EntityOperationFailure<YardLog> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        return new(attached, failures);
    }


}
