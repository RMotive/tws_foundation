

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

    private static IQueryable<Trailer> Include(IQueryable<Trailer> query) {
        return query
        .Include(t => t.SctNavigation)

        .Include(t => t.CarrierNavigation)
            .ThenInclude(c => c!.AddressNavigation)
        .Include(t => t.CarrierNavigation)
            .ThenInclude(c => c!.ApproachNavigation)
        .Include(t => t.CarrierNavigation)
            .ThenInclude(c => c!.UsdotNavigation)

        .Include(t => t.TrailerCommonNavigation)
                .ThenInclude(t => t!.SituationNavigation)
        .Include(t => t.TrailerCommonNavigation)
            .ThenInclude(t => t!.TrailerTypeNavigation)
        .Include(t => t.TrailerCommonNavigation)
            .ThenInclude(t => t!.LocationNavigation)
                .ThenInclude(t => t!.AddressNavigation)

        .Include(t => t.TrailerCommonNavigation)
            .ThenInclude(t => t!.TrailerTypeNavigation)
                .ThenInclude(t => t!.TrailerClassNavigation)

        .Include(t => t.VehiculesModelsNavigation)
            .ThenInclude(t => t!.ManufacturerNavigation)

        .Include(t => t.MaintenanceNavigation)
        .Include(t => t.Plates)
        .Select(p => new Trailer() {
            Id = p.Id,
            Timestamp = p.Timestamp,
            Status = p.Status,
            Common = p.Common,
            Carrier = p.Carrier,
            Model = p.Model,
            Sct = p.Sct,
            Maintenance = p.Maintenance,
            CarrierNavigation = p.CarrierNavigation == null ? null : new Carrier() {
                Id = p.CarrierNavigation.Id,
                Timestamp = p.CarrierNavigation.Timestamp,
                Status = p.CarrierNavigation.Status,
                Name = p.CarrierNavigation.Name,
                Approach = p.CarrierNavigation.Approach,
                Address = p.CarrierNavigation.Address,
                Usdot = p.CarrierNavigation.Usdot,
                ApproachNavigation = p.CarrierNavigation.ApproachNavigation == null ? null : new Approach() {
                    Id = p.CarrierNavigation.ApproachNavigation.Id,
                    Timestamp = p.CarrierNavigation.ApproachNavigation.Timestamp,
                    Status = p.CarrierNavigation.ApproachNavigation.Status,
                    Enterprise = p.CarrierNavigation.ApproachNavigation.Enterprise,
                    Personal = p.CarrierNavigation.ApproachNavigation.Personal,
                    Alternative = p.CarrierNavigation.ApproachNavigation.Alternative,
                    Email = p.CarrierNavigation.ApproachNavigation.Email,
                },
                AddressNavigation = p.CarrierNavigation.AddressNavigation == null ? null : new Address() { 
                    Id = p.CarrierNavigation.AddressNavigation.Id,
                    Timestamp = p.CarrierNavigation.AddressNavigation.Timestamp,
                    State = p.CarrierNavigation.AddressNavigation.State,
                    Street = p.CarrierNavigation.AddressNavigation.Street,
                    AltStreet = p.CarrierNavigation.AddressNavigation.AltStreet,
                    City = p.CarrierNavigation.AddressNavigation.City,
                    Zip = p.CarrierNavigation.AddressNavigation.Zip,
                    Country = p.CarrierNavigation.AddressNavigation.Country,
                    Colonia = p.CarrierNavigation.AddressNavigation.Colonia,
                },
                UsdotNavigation = p.CarrierNavigation.UsdotNavigation == null ? null : new Usdot() { 
                    Id = p.CarrierNavigation.UsdotNavigation.Id,
                    Timestamp = p.CarrierNavigation.UsdotNavigation.Timestamp,
                    Status = p.CarrierNavigation.UsdotNavigation.Status,
                    Mc = p.CarrierNavigation.UsdotNavigation.Mc,
                    Scac = p.CarrierNavigation.UsdotNavigation.Scac,
                },
            },
            SctNavigation = p.SctNavigation == null ? null : new Sct() {
                Id = p.SctNavigation.Id,
                Timestamp = p.SctNavigation.Timestamp,
                Status = p.SctNavigation.Status,
                Type = p.SctNavigation.Type,
                Number = p.SctNavigation.Number,
                Configuration = p.SctNavigation.Configuration,
            },
            VehiculesModelsNavigation = p.VehiculesModelsNavigation == null ? null : new VehiculeModel() {
                Id = p.VehiculesModelsNavigation.Id,
                Timestamp = p.VehiculesModelsNavigation.Timestamp,
                Status = p.VehiculesModelsNavigation.Status,
                Name = p.VehiculesModelsNavigation.Name,
                Year = p.VehiculesModelsNavigation.Year,
                Manufacturer = p.VehiculesModelsNavigation.Manufacturer,
                ManufacturerNavigation = p.VehiculesModelsNavigation.ManufacturerNavigation == null ? null : new Manufacturer() {
                    Id = p.VehiculesModelsNavigation.ManufacturerNavigation.Id,
                    Timestamp = p.VehiculesModelsNavigation.ManufacturerNavigation.Timestamp,
                    Name = p.VehiculesModelsNavigation.ManufacturerNavigation.Name,
                    Description = p.VehiculesModelsNavigation.ManufacturerNavigation.Description,
                },
            },
            TrailerCommonNavigation = p.TrailerCommonNavigation == null ? null : new TrailerCommon() {
                Id = p.TrailerCommonNavigation.Id,
                Timestamp = p.TrailerCommonNavigation.Timestamp,
                Status = p.TrailerCommonNavigation.Status,
                Economic = p.TrailerCommonNavigation.Economic,
                Type = p.TrailerCommonNavigation.Type,
                Situation = p.TrailerCommonNavigation.Situation,
                Location = p.TrailerCommonNavigation.Location,
                SituationNavigation = p.TrailerCommonNavigation.SituationNavigation == null ? null : new Situation() { 
                    Id = p.TrailerCommonNavigation.SituationNavigation.Id,
                    Timestamp = p.TrailerCommonNavigation.SituationNavigation.Timestamp,
                    Name = p.TrailerCommonNavigation.SituationNavigation.Name,
                    Description = p.TrailerCommonNavigation.SituationNavigation.Description,
                },
                TrailerTypeNavigation = p.TrailerCommonNavigation.TrailerTypeNavigation == null ? null : new TrailerType() {
                    Id = p.TrailerCommonNavigation.TrailerTypeNavigation.Id,
                    Timestamp = p.TrailerCommonNavigation.TrailerTypeNavigation.Timestamp,
                    Status = p.TrailerCommonNavigation.TrailerTypeNavigation.Status,
                    Size = p.TrailerCommonNavigation.TrailerTypeNavigation.Size,
                    TrailerClass = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClass,
                    TrailerClassNavigation = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation == null? null : new TrailerClass() {
                        Id = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Id,
                        Timestamp = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Timestamp,
                        Name = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Name,
                        Description = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Description,
                    }
                },
                LocationNavigation = p.TrailerCommonNavigation.LocationNavigation == null ? null : new Location() {
                    Id = p.TrailerCommonNavigation.LocationNavigation.Id,
                    Timestamp = p.TrailerCommonNavigation.LocationNavigation.Timestamp,
                    Status = p.TrailerCommonNavigation.LocationNavigation.Status,
                    Name = p.TrailerCommonNavigation.LocationNavigation.Name,
                    Address = p.TrailerCommonNavigation.LocationNavigation.Address,
                    AddressNavigation = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation == null ? null : new Address() {
                        Id = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Id,
                        Timestamp = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Timestamp,
                        State = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.State,
                        Street = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Street,
                        AltStreet = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.AltStreet,
                        City = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.City,
                        Zip = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Zip,
                        Country = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Country,
                        Colonia = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Colonia,
                    }
                },
            },
            Plates = (ICollection<Plate>)p.Plates.Select(p => new Plate() {
                Id = p.Id,
                Timestamp = p.Timestamp,
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

    public async Task<SetViewOut<Trailer>> View(SetViewOptions<Trailer> Options) {   
        return await Trailers.View(Options, Include);
    }
    public async Task<SetBatchOut<Trailer>> Create(Trailer[] Trailer) {
        return await Trailers.Create(Trailer);
    }
    public async Task<RecordUpdateOut<Trailer>> Update(Trailer Trailer) {
        return await Trailers.Update(Trailer, Include);
    }
}
