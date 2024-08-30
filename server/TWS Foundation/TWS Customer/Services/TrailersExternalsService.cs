

using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class TrailersExternalsService : ITrailersExternalsService {
    private readonly TrailersExternalsDepot TrailersExternals;

    public TrailersExternalsService(TrailersExternalsDepot trailersExternals) {
        TrailersExternals = trailersExternals;
    }

    public async Task<SetViewOut<TrailerExternal>> View(SetViewOptions Options) {
        static IQueryable<TrailerExternal> include(IQueryable<TrailerExternal> query) {
            return query
            .Include(t => t.TrailerCommonNavigation)
            .Select(p => new TrailerExternal() {
                Id = p.Id,
                Status = p.Status,
                Common = p.Common,
                TrailerCommonNavigation = p.TrailerCommonNavigation == null ? null : new TrailerCommon() {
                    Id = p.TrailerCommonNavigation.Id,
                    Status = p.TrailerCommonNavigation.Status,
                    Economic = p.TrailerCommonNavigation.Economic,
                    Class = p.TrailerCommonNavigation.Class,
                    Carrier = p.TrailerCommonNavigation.Carrier,
                    Situation = p.TrailerCommonNavigation.Situation,
                    Location = p.TrailerCommonNavigation.Location,
                    CarrierNavigation = p.TrailerCommonNavigation.CarrierNavigation,
                    SituationNavigation = p.TrailerCommonNavigation.SituationNavigation,
                    TrailerClassNavigation = p.TrailerCommonNavigation.TrailerClassNavigation,
                    LocationNavigation = p.TrailerCommonNavigation.LocationNavigation,
                    Plates = (ICollection<Plate>)p.TrailerCommonNavigation.Plates.Select(p => new Plate() {
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
        return await TrailersExternals.View(Options, include);
    }
}
