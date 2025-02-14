using CSM_Foundation.Database.Entity;

using Microsoft.Extensions.DependencyInjection;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Customer.Managers.Depot;
public sealed class DepotManager {
    private readonly IServiceProvider SP;

    public DepotManager(IServiceProvider ServiceProvider) {
        SP = ServiceProvider;
    }


    public IDepot<IEntity> Compose(Type SetType) {
        IServiceProvider scope = SP.CreateScope().ServiceProvider;

        return SetType switch {
            Type _ when SetType == typeof(YardLog) => (IDepot<IEntity>)scope.GetRequiredService(typeof(YardLogsDepot)),

            _ => throw new Exception()
        };
    }
}
