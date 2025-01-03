

using TWS_Business.Depots;
using TWS_Business;
using TWS_Customer.Services.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;
using TWS_Business.Sets;
using Microsoft.EntityFrameworkCore;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Core.Utils;
using Microsoft.EntityFrameworkCore.ChangeTracking;


namespace TWS_Customer.Services;
public class LocationsService : ILocationsService {
    private readonly LocationsDepot Locations;
    private readonly TWSBusinessDatabase Database;
    protected readonly IDisposer? Disposer;

    public LocationsService(LocationsDepot Locations ,TWSBusinessDatabase Database, IDisposer? Disposer) {
        this.Locations = Locations;
        this.Database = Database;
        this.Disposer = Disposer;
    }

    private IQueryable<Location> Include(IQueryable<Location> query) {
        return query
            .Select(p => new Location {
                Id = p.Id,
                Timestamp = p.Timestamp,
                Status = p.Status,
                Name = p.Name,
                Address = p.Address,
                Waypoint = p.Waypoint,
                AddressNavigation = p.AddressNavigation == null ? null : new Address() {
                    Id = p.AddressNavigation.Id,
                    Timestamp = p.AddressNavigation.Timestamp,
                    State = p.AddressNavigation.State,
                    Street = p.AddressNavigation.Street,
                    AltStreet = p.AddressNavigation.AltStreet,
                    City = p.AddressNavigation.City,
                    Zip = p.AddressNavigation.Zip,
                    Country = p.AddressNavigation.Country,
                    Colonia = p.AddressNavigation.Colonia,
                },
                WaypointNavigation = p.WaypointNavigation == null ? null : new Waypoint() {
                    Id = p.WaypointNavigation.Id,
                    Timestamp = p.WaypointNavigation.Timestamp,
                    Status = p.WaypointNavigation.Status,
                    Longitude = p.WaypointNavigation.Longitude,
                    Latitude = p.WaypointNavigation.Latitude,
                    Altitude = p.WaypointNavigation.Altitude,
                }
            });
    }
    public async Task<SetViewOut<Location>> View(SetViewOptions<Location> Options) {
        return await Locations.View(Options, Include);

    }

    public Task<SetBatchOut<Location>> Create(Location[] Locations) {
        return this.Locations.Create(Locations);
    }

    public async Task<RecordUpdateOut<Location>> Update(Location Location) {
        // Evaluate record.
        Location.EvaluateWrite();
        // Check if the trailer currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        Location? current = await Include(Database.Locations)
            .Where(i => i.Id == Location.Id)
            .FirstOrDefaultAsync();

        // If trailer not exist in database, then use the generic update method.
        if (current == null) {
            return await Locations.Update(Location, Include);
        }
        // Save a deep copy before changes.
        Location previousDeepCopy = current.DeepCopy();

        // Clear the navigation to avoid duplicated tracking issues.
        current.AddressNavigation = null;
        current.WaypointNavigation = null;

        current.StatusNavigation = null;

        Database.Attach(current);

        // Update the main model properties.
        EntityEntry previousEntry = Database.Entry(current);
        previousEntry.CurrentValues.SetValues(Location);

        // ---> Update Address Navigation
        if (Location.AddressNavigation != null) {
            current.Address = Location.AddressNavigation.Id;
            current.AddressNavigation = Location.AddressNavigation;
        }

        // ---> Update Waypoint Navigation
        if (Location.WaypointNavigation != null) {
            current.Waypoint = Location.WaypointNavigation.Id;
            current.WaypointNavigation = Location.WaypointNavigation;
        }

        await Database.SaveChangesAsync();
        Disposer?.Push(Database, Location);

        // Get the lastest record data from database.
        Location? lastestRecord = await Include(Database.Locations)
            .Where(i => i.Id == Location.Id)
            .FirstOrDefaultAsync();

        return new RecordUpdateOut<Location> {
            Previous = previousDeepCopy,
            Updated = lastestRecord ?? Location,
        };
    }
}
