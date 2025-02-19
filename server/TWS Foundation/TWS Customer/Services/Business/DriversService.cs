

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Employees;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class DriversService : IDriversService {
    private readonly DriversDepot Drivers;

    public DriversService(DriversDepot drivers) {
        Drivers = drivers;
    }

    public async Task<SetViewOut<Driver>> View(SetViewOptions<Driver> Options) {
        static IQueryable<Driver> include(IQueryable<Driver> query) {
            return query
            .Include(t => t.DriverCommonNavigation)
            .Include(t => t.EmployeeNavigation)
                .ThenInclude(i => i!.Identification)
            .Select(t => new Driver() {
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
                        Description = t.DriverCommonNavigation.SituationNavigation.Description
                    }
                },
                EmployeeNavigation = t.EmployeeNavigation == null ? null : new Employee() {
                    Id = t.EmployeeNavigation.Id,
                    Status = t.EmployeeNavigation.Status,
                    Identification = t.EmployeeNavigation.Identification,
                    Address = t.EmployeeNavigation.Address,
                    Approach = t.EmployeeNavigation.Approach,
                    CURP = t.EmployeeNavigation.CURP,
                    RFC = t.EmployeeNavigation.RFC,
                    NSS = t.EmployeeNavigation.NSS,
                }

            });


        }
        return await Drivers.View(Options, include);
    }
}
