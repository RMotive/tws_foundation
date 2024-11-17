using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class TrucksService : ITrucksService {
    private readonly TruckDepot Trucks;
    private readonly TWSBusinessDatabase Database;
    protected readonly IDisposer? Disposer;

    public TrucksService(TruckDepot Trucks, TWSBusinessDatabase Database, IDisposer? Disposer) {
        this.Trucks = Trucks;
        this.Database = Database;
        this.Disposer = Disposer;
    }


    private IQueryable<Truck> Include(IQueryable<Truck> query) {
        return query
            .Select(t => new Truck() {
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
                    ApproachNavigation = t.CarrierNavigation.ApproachNavigation == null ? null : new Approach() {
                        Id = t.CarrierNavigation.ApproachNavigation.Id,
                        Timestamp = t.CarrierNavigation.ApproachNavigation.Timestamp,
                        Status = t.CarrierNavigation.ApproachNavigation.Status,
                        Enterprise = t.CarrierNavigation.ApproachNavigation.Enterprise,
                        Personal = t.CarrierNavigation.ApproachNavigation.Personal,
                        Alternative = t.CarrierNavigation.ApproachNavigation.Alternative,
                        Email = t.CarrierNavigation.ApproachNavigation.Email,
                    },
                    UsdotNavigation = t.CarrierNavigation.UsdotNavigation == null ? null : new Usdot() {
                        Id = t.CarrierNavigation.UsdotNavigation.Id,
                        Timestamp = t.CarrierNavigation.UsdotNavigation.Timestamp,
                        Status = t.CarrierNavigation.UsdotNavigation.Status,
                        Mc = t.CarrierNavigation.UsdotNavigation.Mc,
                        Scac = t.CarrierNavigation.UsdotNavigation.Scac,
                    },
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
                        AddressNavigation = t.TruckCommonNavigation.LocationNavigation.AddressNavigation == null ? null : new Address() {
                            Id = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Id,
                            Timestamp = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Timestamp,
                            State = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.State,
                            Street = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Street,
                            AltStreet = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.AltStreet,
                            City = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.City,
                            Zip = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Zip,
                            Country = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Country,
                            Colonia = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Colonia,
                        },
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
                    ManufacturerNavigation = t.VehiculeModelNavigation.ManufacturerNavigation == null ? null : new Manufacturer() {
                        Id = t.VehiculeModelNavigation.ManufacturerNavigation.Id,
                        Timestamp = t.VehiculeModelNavigation.ManufacturerNavigation.Timestamp,
                        Name = t.VehiculeModelNavigation.ManufacturerNavigation.Name,
                        Description = t.VehiculeModelNavigation.ManufacturerNavigation.Description,
                    },
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
        return await Trucks.View(options, Include);
    }

    public async Task<SetBatchOut<Truck>> Create(Truck[] Trucks) {
        return await this.Trucks.Create(Trucks);
    }
    //Custom update method implementation for trucks records.
    public async Task<RecordUpdateOut<Truck>> Update(Truck Truck) {
        // Evaluate record.
        Truck.EvaluateWrite();
        // Check if the trailer currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        Truck? current = await Include(Database.Trucks)
            .Where(i => i.Id == Truck.Id)
            .FirstOrDefaultAsync();

        // If trailers not exist in database, then use the generic update method.
        if (current == null) {
            return await Trucks.Update(Truck, Include);
        }
        // Save a deep copy before changes.
        Truck previousDeepCopy = current.DeepCopy();

        // Clear the navigation to avoid duplicated tracking issues.
        current.CarrierNavigation = null;
        current.MaintenanceNavigation = null;
        current.SctNavigation = null;
        current.TruckCommonNavigation = null;
        current.VehiculeModelNavigation = null;
        current.StatusNavigation = null;    
        current.InsuranceNavigation = null;

        // Preserve a copy before modifications.
        Database.Attach(current);

        // Update the main model properties.
        EntityEntry previousEntry = Database.Entry(current);
        previousEntry.CurrentValues.SetValues(Truck);

        // ---> Update SCT navigation
        if (Truck.SctNavigation != null) {
            current.Sct = Truck.SctNavigation.Id;
            current.SctNavigation = Truck.SctNavigation;
        }

        // ---> Update Carrier navigation
        if (Truck.CarrierNavigation != null) {
            current.Carrier = Truck.CarrierNavigation.Id;
            current.CarrierNavigation = Truck.CarrierNavigation;
        }

        // ---> Update Insurance navigation
        if (Truck.InsuranceNavigation != null) {
            current.Model = Truck.InsuranceNavigation.Id;
            current.InsuranceNavigation = Truck.InsuranceNavigation;
        }

        // ---> Update VehiculeModel navigation
        if (Truck.VehiculeModelNavigation != null) {
            current.Model = Truck.VehiculeModelNavigation.Id;
            current.VehiculeModelNavigation = Truck.VehiculeModelNavigation;
        }

        // ---> Update Maintenance navigation
        if (Truck.MaintenanceNavigation != null) {
            current.Maintenance = Truck.MaintenanceNavigation.Id;
            current.MaintenanceNavigation = Truck.MaintenanceNavigation;
        }

        // ---> Update TrailerCommon navigation
        if (Truck.TruckCommonNavigation != null) {
            current.Common = Truck.TruckCommonNavigation.Id;
            current.TruckCommonNavigation = Truck.TruckCommonNavigation;
        }

        // ---> Update Situation navigation
        if (Truck.TruckCommonNavigation?.SituationNavigation != null) {
            current.TruckCommonNavigation!.Situation = Truck.TruckCommonNavigation!.SituationNavigation!.Id;
            current.TruckCommonNavigation!.SituationNavigation = Truck.TruckCommonNavigation!.SituationNavigation;
        }

        // --> Plates
        // Perform iterations to find new items and modify the current items.
        List<Plate> plates = [.. Truck.Plates];
        List<Plate> currentPlates = [.. current.Plates];

        // Check if the plates lists has the same order.
        if (plates.First().Id != currentPlates.First().Id) {
            //Ordererig the lists to avoid wrong keys exceptions.
            plates = [.. plates.OrderBy(plate => plate.Id)];
            currentPlates = [.. currentPlates.OrderBy(plate => plate.Id)];
        }

        // Search new items to add in the given Trailer record.
        for (int i = 0; i < plates.Count; i++) {
            Plate plate = plates[i];
            //Add new plate.
            if (plate.Id <= 0) {
                // Getting the item type to add.
                Type itemType = plate.GetType();
                // Getting the Add method from Icollection.
                var addMethod = current.Plates.GetType().GetMethod("Add", [itemType]);
                // Adding the new item to Icollection.
                _ = (addMethod?.Invoke(current.Plates, [plate]));
            } else if (plate.Id > 0) {
                //Modify an existent plate
                Database.Entry(currentPlates[i]).CurrentValues.SetValues(plate);
            }
        }

        await Database.SaveChangesAsync();
        Disposer?.Push(Database, Truck);
        // Get the lastest record data from database.
        Truck? lastestRecord = await Include(Database.Trucks)
            .Where(i => i.Id == Truck.Id)
            .FirstOrDefaultAsync();

        return new RecordUpdateOut<Truck> {
            Previous = previousDeepCopy,
            Updated = lastestRecord ?? Truck,
        };
    }



}
