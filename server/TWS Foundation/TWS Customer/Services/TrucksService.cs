using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

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

    public async Task<SetViewOut<Truck>> View(SetViewOptions options) {

        static IQueryable<Truck> include(IQueryable<Truck> query) {
            return query
            .Include(t => t.InsuranceNavigation)
            .Include(t => t.ManufacturerNavigation)
            .Include(t => t.MaintenanceNavigation)
            .Include(t => t.TruckCommonNavigation)
            .Include(t => t.CarrierNavigation)
            .Include(t => t.StatusNavigation)
            .Select(t => new Truck() {
                Id = t.Id,
                Status = t.Status,
                Common = t.Common,
                Motor = t.Motor,
                Manufacturer = t.Manufacturer,
                Maintenance = t.Maintenance,
                Insurance = t.Insurance,
                CarrierNavigation = t.CarrierNavigation,
                Vin = t.Vin,
                StatusNavigation = t.StatusNavigation == null? null : new Status() {
                    Id = t.StatusNavigation.Id,
                    Name = t.StatusNavigation.Name,
                    Description = t.StatusNavigation.Description,
                },
                TruckCommonNavigation = t.TruckCommonNavigation == null ? null : new TruckCommon() {
                    Id = t.TruckCommonNavigation.Id,
                    Economic = t.TruckCommonNavigation.Economic,
                    Location = t.TruckCommonNavigation.Location,
                    Situation = t.TruckCommonNavigation.Situation,
                },
                MaintenanceNavigation = t.MaintenanceNavigation == null ? null : new Maintenance() {
                    Id = t.MaintenanceNavigation.Id,
                    Anual = t.MaintenanceNavigation.Anual,
                    Trimestral = t.MaintenanceNavigation.Trimestral
                },
                ManufacturerNavigation = t.ManufacturerNavigation == null ? null : new Manufacturer() {
                    Id = t.ManufacturerNavigation.Id,
                    Model = t.ManufacturerNavigation.Model,
                    Brand = t.ManufacturerNavigation.Brand,
                    Year = t.ManufacturerNavigation.Year
                },
                InsuranceNavigation = t.InsuranceNavigation == null ? null : new Insurance() {
                    Id = t.InsuranceNavigation.Id,
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
                    Truck = p.Truck,
                    Trailer = p.Trailer
                })

            });
        }

        return await Trucks.View(options, include);
    }

    public async Task<DatabasesTransactionOut<Truck>> Create(Truck[] trucks) {
        return await this.Trucks.Create(trucks);
    }
    public async Task<RecordUpdateOut<Truck>> Update(Truck Truck) {

        static IQueryable<Truck> include(IQueryable<Truck> query) {
            return query
            .Include(t => t.InsuranceNavigation)
            .Include(t => t.ManufacturerNavigation)
            .Include(t => t.MaintenanceNavigation)
            .Include(t => t.TruckCommonNavigation)
            .Include(t => t.StatusNavigation)
            
            .Include(t => t.TruckCommonNavigation)
                .ThenInclude(c => c!.SituationNavigation)

            .Include(t => t.CarrierNavigation)
                .ThenInclude(c => c!.AddressNavigation)
            .Include(t => t.CarrierNavigation)
                .ThenInclude(c => c!.ApproachNavigation)
            .Include(t => t.CarrierNavigation)
                .ThenInclude(c => c!.SctNavigation)
            .Include(t => t.CarrierNavigation)
                .ThenInclude(c => c!.StatusNavigation)
            .Include(t => t.CarrierNavigation)
                .ThenInclude(c => c!.UsdotNavigation).Select(t => new Truck() {
                    Id = t.Id,
                    Status = t.Status,
                    Manufacturer = t.Manufacturer,
                    Motor = t.Motor,
                    Maintenance = t.Maintenance,
                    Insurance = t.Insurance,
                    Carrier = t.Carrier,
                    Vin = t.Vin,
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
                        Sct = t.CarrierNavigation.Sct,
                        ApproachNavigation = t.CarrierNavigation.ApproachNavigation,
                        AddressNavigation = t.CarrierNavigation.AddressNavigation,
                        UsdotNavigation = t.CarrierNavigation.UsdotNavigation,
                        SctNavigation = t.CarrierNavigation.SctNavigation
                    },
                    TruckCommonNavigation = t.TruckCommonNavigation == null ? null : new TruckCommon() {
                        Id = t.TruckCommonNavigation.Id,
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
                    ManufacturerNavigation = t.ManufacturerNavigation == null ? null : new Manufacturer() {
                        Id = t.ManufacturerNavigation.Id,
                        Model = t.ManufacturerNavigation.Model,
                        Brand = t.ManufacturerNavigation.Brand,
                        Year = t.ManufacturerNavigation.Year,
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

        return await Trucks.Update(Truck, include);


    }



}
