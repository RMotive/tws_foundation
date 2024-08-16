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
            .Include(t => t.SctNavigation)
            .Include(t => t.SituationNavigation)
            .Include(t => t.Plates)
            .Select(t => new Truck() {
                Id = t.Id,
                Vin = t.Vin,
                Manufacturer = t.Manufacturer,
                Motor = t.Motor,
                Sct = t.Sct,
                Maintenance = t.Maintenance,
                Situation = t.Situation,
                Insurance = t.Insurance,
                SctNavigation = t.SctNavigation == null ? null : new Sct() {
                    Id = t.SctNavigation.Id,
                    Type = t.SctNavigation.Type,
                    Number = t.SctNavigation.Number,
                    Configuration = t.SctNavigation.Configuration
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
                SituationNavigation = t.SituationNavigation == null ? null : new Situation() {
                    Id = t.SituationNavigation.Id,
                    Name = t.SituationNavigation.Name,
                    Description = t.SituationNavigation.Description
                },
                Plates = (ICollection<Plate>)t.Plates.Select(p => new Plate() {
                    Id = p.Id,
                    Identifier = p.Identifier,
                    State = p.State,
                    Country = p.Country,
                    Expiration = p.Expiration,
                    Truck = p.Truck
                })
            });
        }

        return await Trucks.View(options, include);
    }

    public async Task<SourceTransactionOut<Truck>> Create(Truck[] trucks) {
        return await Trucks.Create(trucks);

    }
}
