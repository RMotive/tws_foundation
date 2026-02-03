using CSM_Foundation;
using CSM_Foundation.Customer;

using TWS_Business;
using TWS_Business.Depots.Indicators;
using TWS_Business.Entities;


namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Status"/> based [Service] implementations.
/// </summary>
public interface IStatusesService
    : IReferenceService<Status> {
}

/// <summary>
///     [Service] for <see cref="Status"/> based operations.
/// </summary>
public class StatusesService
    : BReferenceService<Status, StatusesDepot>, IStatusesService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="StatusService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref=""/> based [Depot] handler to be used.
    /// </param>
    public StatusesService(StatusesDepot Depot, Database Database) : base(Depot) {
        _db = Database;
    }
}
