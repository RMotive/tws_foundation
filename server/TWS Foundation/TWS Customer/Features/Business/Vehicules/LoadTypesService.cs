using CSM_Foundation;
using CSM_Foundation.Customer;

using TWS_Business;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

namespace TWS_Customer.Features.Business.Vehicules;

/// <summary>
///     [Interface] for <see cref="LoadType"/> based [Service] implementations.
/// </summary>
public interface ILoadTypesService
    : IReferenceService<LoadType> {
}

/// <summary>
///     [Service] for <see cref="Address"/> based operations.
/// </summary>
public class LoadTypesService
    : BReferenceService<LoadType, LoadTypesDepot>, ILoadTypesService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="LoadTypesService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref=""/> based [Depot] handler to be used.
    /// </param>
    public LoadTypesService(LoadTypesDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }
}
