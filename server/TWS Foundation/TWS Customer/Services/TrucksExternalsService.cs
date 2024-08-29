

using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class TrucksExternalsService : ITrucksExternalsService {
    private readonly TrucksExternalsDepot TrucksExternals;

    public TrucksExternalsService(TrucksExternalsDepot trucksExternals) {
        TrucksExternals = trucksExternals;
    }

    public async Task<SetViewOut<TruckExternal>> View(SetViewOptions Options) {
        static IQueryable<TruckExternal> include(IQueryable<TruckExternal> query) {
            return query
            .Include(t => t.TruckCommonNavigation)
            .Select(t => new TruckExternal() {
                Status = t.Status,
                Common = t.Common,
                TruckCommonNavigation = t.TruckCommonNavigation == null ? null : new TruckCommon() {
                    Id = t.TruckCommonNavigation.Id,
                    Vin = t.TruckCommonNavigation.Vin,
                    Economic = t.TruckCommonNavigation.Economic,
                    Carrier = t.TruckCommonNavigation.Carrier,
                    Location = t.TruckCommonNavigation.Location,
                    Situation = t.TruckCommonNavigation.Situation,
                    Plates = (ICollection<Plate>)t.TruckCommonNavigation.Plates.Select(p => new Plate() {
                        Id = p.Id,
                        Status = p.Status,
                        Identifier = p.Identifier,
                        State = p.State,
                        Country = p.Country,
                        Expiration = p.Expiration,
                        Truck = p.Truck,
                        Trailer = p.Trailer
                    })
                },
            });

        }
        return await TrucksExternals.View(Options, include);
    }
}
