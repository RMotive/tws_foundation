

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
public class SectionsService : ISectionsService {
    private readonly SectionsDepot Sections;
    private readonly TWSBusinessDatabase Database;
    protected readonly IDisposer? Disposer;
    public SectionsService(SectionsDepot Sections, TWSBusinessDatabase Database, IDisposer? Disposer) {
        this.Sections = Sections;
        this.Database = Database;
        this.Disposer = Disposer;
    }
    private IQueryable<Section> Include(IQueryable<Section> query) {
        return query.Select(p => new Section {
            Id = p.Id,
            Timestamp = p.Timestamp,
            Status = p.Status,
            Name = p.Name,
            Yard = p.Yard,
            Capacity = p.Capacity,
            Ocupancy = p.Ocupancy,
            LocationNavigation = p.LocationNavigation == null? null : new Location() {
                Id = p.LocationNavigation.Id,
                Timestamp = p.LocationNavigation.Timestamp,
                Status = p.LocationNavigation.Status,
                Name = p.LocationNavigation.Name,
                Address = p.LocationNavigation.Address,
                AddressNavigation = p.LocationNavigation.AddressNavigation == null ? null : new Address() {
                    Id = p.LocationNavigation.AddressNavigation.Id,
                    Timestamp = p.LocationNavigation.AddressNavigation.Timestamp,
                    State = p.LocationNavigation.AddressNavigation.State,
                    Street = p.LocationNavigation.AddressNavigation.Street,
                    AltStreet = p.LocationNavigation.AddressNavigation.AltStreet,
                    City = p.LocationNavigation.AddressNavigation.City,
                    Zip = p.LocationNavigation.AddressNavigation.Zip,
                    Country = p.LocationNavigation.AddressNavigation.Country,
                    Colonia = p.LocationNavigation.AddressNavigation.Colonia,
                },
                WaypointNavigation = p.LocationNavigation.WaypointNavigation == null ? null : new Waypoint() {
                    Id = p.LocationNavigation.WaypointNavigation.Id,
                    Timestamp = p.LocationNavigation.WaypointNavigation.Timestamp,
                    Status = p.LocationNavigation.WaypointNavigation.Status,
                    Longitude = p.LocationNavigation.WaypointNavigation.Longitude,
                    Latitude = p.LocationNavigation.WaypointNavigation.Latitude,
                    Altitude = p.LocationNavigation.WaypointNavigation.Altitude,
                }
            },
        });
    }
    public async Task<SetViewOut<Section>> View(SetViewOptions<Section> Options) {
      
        return await Sections.View(Options, Include);
    }

    public Task<SetBatchOut<Section>> Create(Section[] Sections) {
        return this.Sections.Create(Sections);
    }

    public async Task<RecordUpdateOut<Section>> Update(Section Section) {
        // Evaluate record.
        Section.EvaluateWrite();
        // Check if the trailer currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        Section? current = await Include(Database.Sections)
            .Where(i => i.Id == Section.Id)
            .FirstOrDefaultAsync();

        // If trailer not exist in database, then use the generic update method.
        if (current == null) {
            return await Sections.Update(Section, Include);
        }
        // Save a deep copy before changes.
        Section previousDeepCopy = current.DeepCopy();

        // Clear the navigation to avoid duplicated tracking issues.

        current.StatusNavigation = null;
        current.LocationNavigation = null;

        Database.Attach(current);

        // Update the main model properties.
        EntityEntry previousEntry = Database.Entry(current);
        previousEntry.CurrentValues.SetValues(Section);

        // ---> Update Location Navigation
        if (Section.LocationNavigation != null) {
            current.Yard = Section.LocationNavigation.Id;
            current.LocationNavigation = Section.LocationNavigation;
            // ---> Update Address Navigation
            if (Section.LocationNavigation.AddressNavigation != null) {
                current.LocationNavigation.Address = Section.LocationNavigation.AddressNavigation.Id;
                current.LocationNavigation.AddressNavigation = Section.LocationNavigation.AddressNavigation;
            }
        }


        await Database.SaveChangesAsync();
        Disposer?.Push(Database, Section);

        // Get the lastest record data from database.
        Section? lastestRecord = await Include(Database.Sections)
            .Where(i => i.Id == Section.Id)
            .FirstOrDefaultAsync();

        return new RecordUpdateOut<Section> {
            Previous = previousDeepCopy,
            Updated = lastestRecord ?? Section,
        };
    }
}
