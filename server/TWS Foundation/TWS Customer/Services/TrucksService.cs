using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class TrucksService : ITrucksService {
    private readonly TruckDepot Trucks;

    public TrucksService(TruckDepot Trucks) {
        this.Trucks = Trucks;
    }


    private IQueryable<Truck> include(IQueryable<Truck> query) {
        return query
        .Include(t => t.InsuranceNavigation)
        .Include(t => t.VehiculeModelNavigation)
        .Include(t => t.MaintenanceNavigation)
        .Include(t => t.TruckCommonNavigation)
        .Include(t => t.StatusNavigation)
        .Include(t => t.SctNavigation)

        .Include(t => t.TruckCommonNavigation)
            .ThenInclude(c => c!.SituationNavigation)

        .Include(t => t.CarrierNavigation)
            .ThenInclude(c => c!.AddressNavigation)
        .Include(t => t.CarrierNavigation)
            .ThenInclude(c => c!.ApproachNavigation)
        .Include(t => t.CarrierNavigation)
            .ThenInclude(c => c!.UsdotNavigation).Select(t => new Truck() {
                Id = t.Id,
                Status = t.Status,
                Model = t.Model,
                Motor = t.Motor,
                Maintenance = t.Maintenance,
                Insurance = t.Insurance,
                Carrier = t.Carrier,
                Common = t.Common,
                Sct = t.Sct,
                Vin = t.Vin,
                SctNavigation = t.SctNavigation == null ? null : new Sct() {
                    Id = t.SctNavigation.Id,
                    Status = t.SctNavigation.Status,
                    Type = t.SctNavigation.Type,
                    Number = t.SctNavigation.Number,
                    Configuration = t.SctNavigation.Configuration,
                },
                StatusNavigation = t.StatusNavigation == null ? null : new Status() {
                    Id = t.StatusNavigation.Id,
                    Name = t.StatusNavigation.Name,
                    Description = t.StatusNavigation.Description,
                },
                CarrierNavigation = t.CarrierNavigation == null ? null : new Carrier() {
                    Id = t.CarrierNavigation.Id,
                    Status = t.CarrierNavigation.Status,
                    Name = t.CarrierNavigation.Name,
                    Approach = t.CarrierNavigation.Approach,
                    Address = t.CarrierNavigation.Address,
                    Usdot = t.CarrierNavigation.Usdot,
                    ApproachNavigation = t.CarrierNavigation.ApproachNavigation,
                    AddressNavigation = t.CarrierNavigation.AddressNavigation,
                    UsdotNavigation = t.CarrierNavigation.UsdotNavigation,
                },
                TruckCommonNavigation = t.TruckCommonNavigation == null ? null : new TruckCommon() {
                    Id = t.TruckCommonNavigation.Id,
                    Status = t.TruckCommonNavigation.Status,
                    Economic = t.TruckCommonNavigation.Economic,
                    Location = t.TruckCommonNavigation.Location,
                    Situation = t.TruckCommonNavigation.Situation,
                    LocationNavigation = t.TruckCommonNavigation.LocationNavigation == null ? null : new Location() {
                        Id = t.TruckCommonNavigation.LocationNavigation.Id,
                        Status = t.TruckCommonNavigation.LocationNavigation.Status,
                        Name = t.TruckCommonNavigation.LocationNavigation.Name,
                        Address = t.TruckCommonNavigation.LocationNavigation.Address,
                        AddressNavigation = t.TruckCommonNavigation.LocationNavigation.AddressNavigation
                    },
                    SituationNavigation = t.TruckCommonNavigation.SituationNavigation == null ? null : new Situation() {
                        Id = t.TruckCommonNavigation.SituationNavigation.Id,
                        Name = t.TruckCommonNavigation.SituationNavigation.Name,
                        Description = t.TruckCommonNavigation.SituationNavigation.Description
                    },
                },
                MaintenanceNavigation = t.MaintenanceNavigation == null ? null : new Maintenance() {
                    Id = t.MaintenanceNavigation.Id,
                    Status = t.MaintenanceNavigation.Status,
                    Anual = t.MaintenanceNavigation.Anual,
                    Trimestral = t.MaintenanceNavigation.Trimestral,
                },
                VehiculeModelNavigation = t.VehiculeModelNavigation == null ? null : new VehiculeModel() {
                    Id = t.VehiculeModelNavigation.Id,
                    Status = t.VehiculeModelNavigation.Status,
                    Name = t.VehiculeModelNavigation.Name,
                    Year = t.VehiculeModelNavigation.Year,
                    Manufacturer = t.VehiculeModelNavigation.Manufacturer,
                    ManufacturerNavigation = t.VehiculeModelNavigation.ManufacturerNavigation,
                },
                InsuranceNavigation = t.InsuranceNavigation == null ? null : new Insurance() {
                    Id = t.InsuranceNavigation.Id,
                    Status = t.InsuranceNavigation.Status,
                    Policy = t.InsuranceNavigation.Policy,
                    Expiration = t.InsuranceNavigation.Expiration,
                    Country = t.InsuranceNavigation.Country
                },
                Plates = (ICollection<Plate>)t.Plates.Select(p => new Plate() {
                    Id = p.Id,
                    Status = p.Status,
                    Identifier = p.Identifier,
                    State = p.State,
                    Country = p.Country,
                    Expiration = p.Expiration,
                    Truck = p.Truck
                })
            });
    }
    public async Task<SetViewOut<Truck>> View(SetViewOptions<Truck> options) {
        return await Trucks.View(options, include);
    }

    public async Task<SetBatchOut<Truck>> Create(Truck[] trucks) {
        return await this.Trucks.Create(trucks);
    }
    public async Task<RecordUpdateOut<Truck>> Update(Truck Truck) {
        return await Trucks.Update(Truck, include);
    }



}
