

using System.Security.Cryptography;

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

using Xunit;

namespace TWS_Customer.Services;
public class TrailersService : ITrailersService {
    private readonly TrailersDepot Trailers;
    private readonly TWSBusinessDatabase Database;
    protected readonly IDisposer? Disposer;

    public TrailersService(TrailersDepot Trailers, TWSBusinessDatabase Database, IDisposer? Disposer) {
        this.Trailers = Trailers;
        this.Database = Database;
        this.Disposer = Disposer;
    }   

    private static IQueryable<Trailer> Include(IQueryable<Trailer> query) {
        return query
        .Select(p => new Trailer() {
            Id = p.Id,
            Timestamp = p.Timestamp,
            Status = p.Status,
            Common = p.Common,
            Carrier = p.Carrier,
            Model = p.Model,
            Sct = p.Sct,
            Maintenance = p.Maintenance,
            MaintenanceNavigation = p.MaintenanceNavigation == null ? null : new Maintenance() {
                Id = p.MaintenanceNavigation.Id,
                Timestamp = p.MaintenanceNavigation.Timestamp,
                Status = p.MaintenanceNavigation.Status,
                Anual = p.MaintenanceNavigation.Anual,
                Trimestral = p.MaintenanceNavigation.Trimestral,
            },
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
            VehiculeModelNavigation = p.VehiculeModelNavigation == null ? null : new VehiculeModel() {
                Id = p.VehiculeModelNavigation.Id,
                Timestamp = p.VehiculeModelNavigation.Timestamp,
                Status = p.VehiculeModelNavigation.Status,
                Name = p.VehiculeModelNavigation.Name,
                Year = p.VehiculeModelNavigation.Year,
                Manufacturer = p.VehiculeModelNavigation.Manufacturer,
                ManufacturerNavigation = p.VehiculeModelNavigation.ManufacturerNavigation == null ? null : new Manufacturer() {
                    Id = p.VehiculeModelNavigation.ManufacturerNavigation.Id,
                    Timestamp = p.VehiculeModelNavigation.ManufacturerNavigation.Timestamp,
                    Name = p.VehiculeModelNavigation.ManufacturerNavigation.Name,
                    Description = p.VehiculeModelNavigation.ManufacturerNavigation.Description,
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
                    TrailerClassNavigation = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation == null ? null : new TrailerClass() {
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
                    },
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

    // Custom update method implementation for trailers records.
    public async Task<RecordUpdateOut<Trailer>> Update(Trailer Trailer) {
        // Evaluate record.
        Trailer.EvaluateWrite();
        // Check if the trailer currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        Trailer? current = await Include(Database.Trailers)
            .Where(i => i.Id == Trailer.Id)
            .FirstOrDefaultAsync();

        // If trailer not exist in database, then use the generic update method.
        if (current == null) {
            return await Trailers.Update(Trailer, Include);
        }
        // Save a deep copy before changes.
        Trailer previousDeepCopy = current.DeepCopy();

        // Clear the navigation to avoid duplicated tracking issue.
        current.CarrierNavigation = null;
        current.MaintenanceNavigation = null;
        current.SctNavigation = null;
        current.TrailerCommonNavigation = null;
        current.VehiculeModelNavigation = null;
        current.StatusNavigation = null;

        Database.Attach(current);

        // Update the main model properties.
        EntityEntry previousEntry = Database.Entry(current);
        previousEntry.CurrentValues.SetValues(Trailer);

        // ---> Update SCT navigation
        if (Trailer.SctNavigation != null) {
            current.Sct = Trailer.SctNavigation.Id;
            current.SctNavigation = Trailer.SctNavigation;
        }

        // ---> Update Carrier navigation
        if (Trailer.CarrierNavigation != null) {
            current.Carrier = Trailer.CarrierNavigation.Id;
            current.CarrierNavigation = Trailer.CarrierNavigation;
        }

        // ---> Update VehiculeModel navigation
        if (Trailer.VehiculeModelNavigation != null) {
            current.Model = Trailer.VehiculeModelNavigation.Id;
            current.VehiculeModelNavigation = Trailer.VehiculeModelNavigation;
        }

        // ---> Update Maintenance navigation
        if (Trailer.MaintenanceNavigation != null) {
            current.Maintenance = Trailer.MaintenanceNavigation.Id;
            current.MaintenanceNavigation = Trailer.MaintenanceNavigation;
        }

        // ---> Update TrailerCommon navigation
        if (Trailer.TrailerCommonNavigation != null) {
            current.Common = Trailer.TrailerCommonNavigation.Id;
            current.TrailerCommonNavigation = Trailer.TrailerCommonNavigation;
        }

        // ---> Update Situation navigation
        if (Trailer.TrailerCommonNavigation?.SituationNavigation != null) {
            current.TrailerCommonNavigation!.Situation = Trailer.TrailerCommonNavigation!.SituationNavigation!.Id;
            current.TrailerCommonNavigation!.SituationNavigation = Trailer.TrailerCommonNavigation!.SituationNavigation;
        }

        // ---> Update TrailerType navigation
        if (Trailer.TrailerCommonNavigation?.TrailerTypeNavigation != null) {
            current.TrailerCommonNavigation!.Type = Trailer.TrailerCommonNavigation!.TrailerTypeNavigation!.Id;
            current.TrailerCommonNavigation!.TrailerTypeNavigation = Trailer.TrailerCommonNavigation!.TrailerTypeNavigation;
        }

        // --> Plates
        // Perform iterations to find new items and modify the current items.
        List<Plate> plates = [.. Trailer.Plates];
        List<Plate> currentPlates = [.. current.Plates];

        // Check if the plates lists has the same order.
        if(plates.First().Id != currentPlates.First().Id) {
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
        Disposer?.Push(Database, Trailer);

        // Get the lastest record data from database.
        Trailer? lastestRecord = await Include(Database.Trailers)
            .Where(i => i.Id == Trailer.Id)
            .FirstOrDefaultAsync();

        return new RecordUpdateOut<Trailer> {
            Previous = previousDeepCopy,
            Updated = lastestRecord ?? Trailer,
        };


    }
}
