

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class TrailersService : ITrailersService {
    private readonly TrailersDepot Trailers;

    public TrailersService(TrailersDepot trailers) {
        Trailers = trailers;
    }

    public async Task<SetViewOut<Trailer>> View(SetViewOptions Options) {
        static IQueryable<Trailer> include(IQueryable<Trailer> query) {
            return query
            .Include(t => t.TrailerCommonNavigation)
            .Include(t => t.CarrierNavigation)
            .Select(p => new Trailer() {
                Id = p.Id,
                Status = p.Status,
                Common = p.Common,
                Carrier = p.Carrier,
                Manufacturer = p.Manufacturer,
                Maintenance = p.Maintenance,
                ManufacturerNavigation = p.ManufacturerNavigation,
                MaintenanceNavigation = p.MaintenanceNavigation,
                CarrierNavigation = p.CarrierNavigation,
                TrailerCommonNavigation = p.TrailerCommonNavigation == null ? null : new TrailerCommon() {
                    Id = p.TrailerCommonNavigation.Id,
                    Status = p.TrailerCommonNavigation.Status,
                    Economic = p.TrailerCommonNavigation.Economic,
                    Class = p.TrailerCommonNavigation.Class,
                    Situation = p.TrailerCommonNavigation.Situation,
                    Location = p.TrailerCommonNavigation.Location,
                    SituationNavigation = p.TrailerCommonNavigation.SituationNavigation,
                    TrailerClassNavigation = p.TrailerCommonNavigation.TrailerClassNavigation,
                    LocationNavigation = p.TrailerCommonNavigation.LocationNavigation,
                },
                Plates = (ICollection<Plate>)p.Plates.Select(p => new Plate() {
                    Id = p.Id,
                    Status = p.Status,
                    Identifier = p.Identifier,
                    State = p.State,
                    Country = p.Country,
                    Expiration = p.Expiration,
                    Truck = p.Truck,
                    Trailer = p.Trailer
                })

            });
        }
        return await Trailers.View(Options, include);
    }
}
