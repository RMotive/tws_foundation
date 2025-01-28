

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
public class DriversExternalsService : IDriversExternalsService {
    private readonly DriversExternalsDepot DriversExternals;
    private readonly TWSBusinessDatabase Database;
    protected readonly IDisposer? Disposer;
    public DriversExternalsService(DriversExternalsDepot DriversExternals, TWSBusinessDatabase Database, IDisposer? Disposer) {
        this.DriversExternals = DriversExternals;
        this.Database = Database;
        this.Disposer = Disposer;
    }
    private static IQueryable<DriverExternal> Include(IQueryable<DriverExternal> query) {
        return query.Select(t => new DriverExternal() {
            Id = t.Id,
            Timestamp = t.Timestamp,
            Status = t.Status,
            Identification  = t.Identification,
            Common = t.Common,
            DriverCommonNavigation = t.DriverCommonNavigation == null? null : new DriverCommon() {
                Id = t.DriverCommonNavigation.Id,
                Timestamp = t.DriverCommonNavigation.Timestamp,
                Status = t.DriverCommonNavigation.Status,
                License = t.DriverCommonNavigation.License,
                Situation = t.DriverCommonNavigation.Situation,
                SituationNavigation = t.DriverCommonNavigation.SituationNavigation == null? null : new Situation(){
                    Id = t.DriverCommonNavigation.SituationNavigation.Id,
                    Timestamp = t.DriverCommonNavigation.SituationNavigation.Timestamp,
                    Name = t.DriverCommonNavigation.SituationNavigation.Name,
                    Description = t.DriverCommonNavigation.SituationNavigation.Description,
                }
            },
            IdentificationNavigation = t.IdentificationNavigation == null? null : new Identification() {
                Id = t.IdentificationNavigation.Id,
                Status = t.IdentificationNavigation.Status,
                Timestamp = t.IdentificationNavigation.Timestamp,
                Name = t.IdentificationNavigation.Name,
                FatherLastname = t.IdentificationNavigation.FatherLastname,
                MotherLastName = t.IdentificationNavigation.MotherLastName,
                Birthday = t.IdentificationNavigation.Birthday,
            },
        });

    }
    public async Task<SetViewOut<DriverExternal>> View(SetViewOptions<DriverExternal> Options) {
        
        return await DriversExternals.View(Options, Include);
    }
    public Task<SetBatchOut<DriverExternal>> Create(DriverExternal[] Drivers) {
        return this.DriversExternals.Create(Drivers);
    }

    public async Task<RecordUpdateOut<DriverExternal>> Update(DriverExternal Driver) {
        // Evaluate record.
        Driver.EvaluateWrite();
        // Check if the trailer currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        DriverExternal? current = await Include(Database.DriverExternals)
            .Where(i => i.Id == Driver.Id)
            .FirstOrDefaultAsync();

        // If trailer not exist in database, then use the generic update method.
        if (current == null) {
            return await DriversExternals.Update(Driver, Include);
        }
        // Save a deep copy before changes.
        DriverExternal previousDeepCopy = current.DeepCopy();

        // Clear the navigation to avoid duplicated tracking issues.
        current.DriverCommonNavigation = null;
        current.IdentificationNavigation = null;
        current.StatusNavigation = null;

        Database.Attach(current);

        // Update the main model properties.
        EntityEntry previousEntry = Database.Entry(current);
        previousEntry.CurrentValues.SetValues(Driver);

        // ---> Update DriverCommons navigation
        if (Driver.DriverCommonNavigation != null) {
            current.Common = Driver.DriverCommonNavigation.Id;
            current.DriverCommonNavigation = Driver.DriverCommonNavigation;
        }

        // ---> Update Identification navigation
        if (Driver.IdentificationNavigation != null) {
            current.Identification = Driver.IdentificationNavigation.Id;
            current.IdentificationNavigation = Driver.IdentificationNavigation;
        }

        await Database.SaveChangesAsync();
        Disposer?.Push(Database, Driver);

        // Get the lastest record data from database.
        DriverExternal? lastestRecord = await Include(Database.DriverExternals)
            .Where(i => i.Id == Driver.Id)
            .FirstOrDefaultAsync();

        return new RecordUpdateOut<DriverExternal> {
            Previous = previousDeepCopy,
            Updated = lastestRecord ?? Driver,
        };
    }
}
