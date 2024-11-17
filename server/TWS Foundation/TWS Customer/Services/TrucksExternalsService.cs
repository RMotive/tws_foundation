

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
public class TrucksExternalsService : ITrucksExternalsService {
    private readonly TrucksExternalsDepot TrucksExternals;
    private readonly TWSBusinessDatabase Database;
    protected readonly IDisposer? Disposer;

    public TrucksExternalsService(TrucksExternalsDepot TrucksExternals, TWSBusinessDatabase Database, IDisposer? Disposer) {
        this.TrucksExternals = TrucksExternals;
        this.Database = Database;
        this.Disposer = Disposer;
    }

    private IQueryable<TruckExternal> Include(IQueryable<TruckExternal> query) {
        return query
            .Select(t => new TruckExternal() {
                Id = t.Id,
                Timestamp = t.Timestamp,
                Status = t.Status,
                Common = t.Common,
                UsaPlate = t.UsaPlate,
                MxPlate = t.MxPlate,
                Carrier = t.Carrier,
                Vin = t.Vin,
                TruckCommonNavigation = t.TruckCommonNavigation == null ? null : new TruckCommon() {
                    Id = t.TruckCommonNavigation.Id,
                    Timestamp = t.TruckCommonNavigation.Timestamp,
                    Status = t.TruckCommonNavigation.Status,
                    Economic = t.TruckCommonNavigation.Economic,
                    Location = t.TruckCommonNavigation.Location,
                    Situation = t.TruckCommonNavigation.Situation,
                    SituationNavigation = t.TruckCommonNavigation.SituationNavigation == null ? null : new Situation() {
                        Id = t.TruckCommonNavigation.SituationNavigation.Id,
                        Timestamp = t.TruckCommonNavigation.SituationNavigation.Timestamp,
                        Name = t.TruckCommonNavigation.SituationNavigation.Name,
                        Description = t.TruckCommonNavigation.SituationNavigation.Description
                    },
                    LocationNavigation = t.TruckCommonNavigation.LocationNavigation == null ? null : new Location() {
                        Id = t.TruckCommonNavigation.LocationNavigation.Id,
                        Timestamp = t.TruckCommonNavigation.LocationNavigation.Timestamp,
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
                            Colonia = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Colonia
                        }
                    },
                },
            });
    }

    public async Task<SetViewOut<TruckExternal>> View(SetViewOptions<TruckExternal> Options) {
        return await TrucksExternals.View(Options, Include);
    }

    public async Task<SetBatchOut<TruckExternal>> Create(TruckExternal[] trucks) {
        return await this.TrucksExternals.Create(trucks);
    }

    public async Task<RecordUpdateOut<TruckExternal>> Update(TruckExternal Truck) {
        // Evaluate record.
        Truck.EvaluateWrite();
        // Check if the trailer currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        TruckExternal? current = await Include(Database.TrucksExternals)
            .Where(i => i.Id == Truck.Id)
            .FirstOrDefaultAsync();

        // If trailers not exist in database, then use the generic update method.
        if (current == null) {
            return await TrucksExternals.Update(Truck, Include);
        }

        // Save a deep copy before changes.
        TruckExternal previousDeepCopy = current.DeepCopy();

        // Clear the navigation to avoid duplicated tracking issue.
        current.TruckCommonNavigation = null;
        current.StatusNavigation = null;

        // Preserve a copy before modifications.
        Database.Attach(current);

        // Update the main model properties.
        EntityEntry previousEntry = Database.Entry(current);
        previousEntry.CurrentValues.SetValues(Truck);

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

        await Database.SaveChangesAsync();
        Disposer?.Push(Database, Truck);

        // Get the lastest record data from database.
        TruckExternal? lastestRecord = await Include(Database.TrucksExternals)
            .Where(i => i.Id == Truck.Id)
            .FirstOrDefaultAsync();

        return new RecordUpdateOut<TruckExternal> {
            Previous = previousDeepCopy,
            Updated = lastestRecord ?? Truck,
        };
    }
}
