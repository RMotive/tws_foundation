using CSM_Foundation.Database.Interfaces;

using Microsoft.Extensions.DependencyInjection;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Customer.Managers.Depot;
public sealed class DepotManager {
    private readonly IServiceProvider SP;

    public DepotManager(IServiceProvider ServiceProvider) {
        SP = ServiceProvider;
    }


    public IDepot<ISet> Compose(Type SetType) {
        IServiceProvider scope = SP.CreateScope().ServiceProvider;

        return SetType switch {
            Type _ when SetType == typeof(YardLog) => (IDepot<ISet>)scope.GetRequiredService(typeof(YardLogsDepot)),

            _ => throw new Exception()
        };
    }
}
