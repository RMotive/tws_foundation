using CSM_Foundation.Customer;

using TWS_Business.Depots;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

namespace TWS_Customer.Features.Business.Vehicules;

/// <summary>
///     [Interface] for <see cref="LoadType"/> based [Service] implementations.
/// </summary>
public interface ILoadTypesService
    : IService<LoadType> {
}

/// <summary>
///     [Service] for <see cref="Address"/> based operations.
/// </summary>
public class LoadTypesService
    : BService<LoadType, ILoadTypesDepot>, ILoadTypesService {

    /// <summary>
    ///     Creates a new instance of <see cref="LoadTypesService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref=""/> based [Depot] handler to be used.
    /// </param>
    public LoadTypesService(ILoadTypesDepot Depot) : base(Depot) { }
}
