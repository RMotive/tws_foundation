using System.Text;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Utilitites;
using CSM_Foundation.Product;

using CSM_Security.Entities;

using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Customer.Quality;


/// <summary>
///     
/// </summary>
/// <typeparam name="TService"></typeparam>
public abstract class BQ_ServicesCustomer<TService>
    : BQ_Service<TService>
    where TService : IService {

    /// <summary>
    /// 
    /// </summary>
    protected string Entropy => RandomUtils.String(16);

    public BQ_ServicesCustomer()
        : base(
                [
                    SecurityDatabaseFactory,
                    BusinessDatabaseFactory,
                ]
            ) {
    }
}
