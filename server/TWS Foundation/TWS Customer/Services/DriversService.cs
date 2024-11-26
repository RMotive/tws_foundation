

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
public class DriversService : IDriversService {
    private readonly DriversDepot Drivers;
    private readonly TWSBusinessDatabase Database;
    protected readonly IDisposer? Disposer;

    public DriversService(DriversDepot Drivers, TWSBusinessDatabase Database, IDisposer? Disposer) {
        this.Drivers = Drivers;
        this.Database = Database;
        this.Disposer = Disposer;
    }
    private static IQueryable<Driver> Include(IQueryable<Driver> query) {
        return query.Select(t => new Driver() {
            Id = t.Id,
            Status = t.Status,
            Employee = t.Employee,
            Common = t.Common,
            DriverType = t.DriverType,
            LicenseExpiration = t.LicenseExpiration,
            DrugalcRegistrationDate = t.DrugalcRegistrationDate,
            PullnoticeRegistrationDate = t.PullnoticeRegistrationDate,
            Twic = t.Twic,
            TwicExpiration = t.TwicExpiration,
            Visa = t.Visa,
            VisaExpiration = t.VisaExpiration,
            Fast = t.Fast,
            FastExpiration = t.FastExpiration,
            Anam = t.Anam,
            AnamExpiration = t.AnamExpiration,
            DriverCommonNavigation = t.DriverCommonNavigation == null ? null : new DriverCommon() {
                Id = t.DriverCommonNavigation.Id,
                Status = t.DriverCommonNavigation.Status,
                License = t.DriverCommonNavigation.License,
                Situation = t.DriverCommonNavigation.Situation,
                SituationNavigation = t.DriverCommonNavigation.SituationNavigation == null ? null : new Situation() {
                    Id = t.DriverCommonNavigation.SituationNavigation.Id,
                    Name = t.DriverCommonNavigation.SituationNavigation.Name,
                    Description = t.DriverCommonNavigation.SituationNavigation.Description,
                }
            },
            EmployeeNavigation = t.EmployeeNavigation == null ? null : new Employee() {
                Id = t.EmployeeNavigation.Id,
                Status = t.EmployeeNavigation.Status,
                Identification = t.EmployeeNavigation.Identification,
                Address = t.EmployeeNavigation.Address,
                Approach = t.EmployeeNavigation.Approach,
                Curp = t.EmployeeNavigation.Curp,
                AntecedentesNoPenaleseExp = t.EmployeeNavigation.AntecedentesNoPenaleseExp,
                Rfc = t.EmployeeNavigation.Rfc,
                Nss = t.EmployeeNavigation.Nss,
                IMSSRegistrationDate = t.EmployeeNavigation.IMSSRegistrationDate,
                HiringDate = t.EmployeeNavigation.HiringDate,
                TerminationDate = t.EmployeeNavigation.TerminationDate,
                IdentificationNavigation = t.EmployeeNavigation.IdentificationNavigation == null ? null : new Identification() {
                    Id = t.EmployeeNavigation.IdentificationNavigation.Id,
                    Status = t.EmployeeNavigation.IdentificationNavigation.Status,
                    Name = t.EmployeeNavigation.IdentificationNavigation.Name,
                    FatherLastname = t.EmployeeNavigation.IdentificationNavigation.FatherLastname,
                    MotherLastName = t.EmployeeNavigation.IdentificationNavigation.MotherLastName,
                    Birthday = t.EmployeeNavigation.IdentificationNavigation.Birthday,
                }
            }

        });
    }
    public Task<SetBatchOut<Driver>> Create(Driver[] Drivers) {
        return this.Drivers.Create(Drivers);
    }

    public async Task<RecordUpdateOut<Driver>> Update(Driver Driver) {
        // Evaluate record.
        Driver.EvaluateWrite();
        // Check if the trailer currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        Driver? current = await Include(Database.Drivers)
            .Where(i => i.Id == Driver.Id)
            .FirstOrDefaultAsync();

        // If trailer not exist in database, then use the generic update method.
        if (current == null) {
            return await Drivers.Update(Driver, Include);
        }
        // Save a deep copy before changes.
        Driver previousDeepCopy = current.DeepCopy();

        // Clear the navigation to avoid duplicated tracking issue.
        current.DriverCommonNavigation = null;
        current.EmployeeNavigation = null;
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

        // ---> Update Employee navigation
        if (Driver.EmployeeNavigation != null) {
            current.Employee = Driver.EmployeeNavigation.Id;
            current.EmployeeNavigation = Driver.EmployeeNavigation;
        }

        await Database.SaveChangesAsync();
        Disposer?.Push(Database, Driver);

        // Get the lastest record data from database.
        Driver? lastestRecord = await Include(Database.Drivers)
            .Where(i => i.Id == Driver.Id)
            .FirstOrDefaultAsync();

        return new RecordUpdateOut<Driver> {
            Previous = previousDeepCopy,
            Updated = lastestRecord ?? Driver,
        };
    }

    public async Task<SetViewOut<Driver>> View(SetViewOptions<Driver> Options) {
        return await Drivers.View(Options, Include);
    }
}
