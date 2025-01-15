

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.BusinessServices;
public class TrailersService : ITrailersService {
    private readonly TrailersDepot Trailers;

    public TrailersService(TrailersDepot trailers) {
        Trailers = trailers;
    }

    public async Task<SetViewOut<Trailer>> View(SetViewOptions<Trailer> Options) {
        static IQueryable<Trailer> include(IQueryable<Trailer> query) {
            return query
            .Include(t => t.TrailerCommonNavigation)

            .Include(t => t.CarrierNavigation)
                .ThenInclude(c => c!.AddressNavigation)
            .Include(t => t.CarrierNavigation)
                .ThenInclude(c => c!.ApproachNavigation)
            .Include(t => t.CarrierNavigation)
                .ThenInclude(c => c!.UsdotNavigation)

            .Include(t => t.VehiculesModelsNavigation)
            .Select(p => new Trailer() {
                Id = p.Id,
                Status = p.Status,
                Common = p.Common,
                Carrier = p.Carrier,
                Model = p.Model,
                Sct = p.Sct,
                Maintenance = p.Maintenance,
                MaintenanceNavigation = p.MaintenanceNavigation,
                CarrierNavigation = p.CarrierNavigation == null ? null : new Carrier() {
                    Id = p.CarrierNavigation.Id,
                    Status = p.CarrierNavigation.Status,
                    Name = p.CarrierNavigation.Name,
                    Approach = p.CarrierNavigation.Approach,
                    Address = p.CarrierNavigation.Address,
                    Usdot = p.CarrierNavigation.Usdot,
                    ApproachNavigation = p.CarrierNavigation.ApproachNavigation,
                    AddressNavigation = p.CarrierNavigation.AddressNavigation,
                    UsdotNavigation = p.CarrierNavigation.UsdotNavigation,
                },
                SctNavigation = p.SctNavigation == null ? null : new Sct() {
                    Id = p.SctNavigation.Id,
                    Status = p.SctNavigation.Status,
                    Type = p.SctNavigation.Type,
                    Number = p.SctNavigation.Number,
                    Configuration = p.SctNavigation.Configuration,
                },
                VehiculesModelsNavigation = p.VehiculesModelsNavigation == null ? null : new VehiculeModel() {
                    Id = p.VehiculesModelsNavigation.Id,
                    Status = p.VehiculesModelsNavigation.Status,
                    Name = p.VehiculesModelsNavigation.Name,
                    Year = p.VehiculesModelsNavigation.Year,
                    Manufacturer = p.VehiculesModelsNavigation.Manufacturer,
                    ManufacturerNavigation = p.VehiculesModelsNavigation.ManufacturerNavigation,
                },
                TrailerCommonNavigation = p.TrailerCommonNavigation == null ? null : new TrailerCommon() {
                    Id = p.TrailerCommonNavigation.Id,
                    Status = p.TrailerCommonNavigation.Status,
                    Economic = p.TrailerCommonNavigation.Economic,
                    Type = p.TrailerCommonNavigation.Type,
                    Situation = p.TrailerCommonNavigation.Situation,
                    Location = p.TrailerCommonNavigation.Location,
                    SituationNavigation = p.TrailerCommonNavigation.SituationNavigation,
                    TrailerTypeNavigation = p.TrailerCommonNavigation.TrailerTypeNavigation,
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
