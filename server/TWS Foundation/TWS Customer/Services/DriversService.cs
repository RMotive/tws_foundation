

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class DriversService : IDriversService {
    private readonly DriversDepot Drivers;

    public DriversService(DriversDepot drivers) {
        Drivers = drivers;
    }

    public async Task<SetViewOut<Driver>> View(SetViewOptions Options) {
        static IQueryable<Driver> include(IQueryable<Driver> query) {
            return query
            .Include(t => t.DriverCommonNavigation)
            .Include(t => t.EmployeeNavigation)
                .ThenInclude(i => i!.IdentificationNavigation)
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
                DriverCommonNavigation = t.DriverCommonNavigation == null? null : new DriverCommon() {
                    Id = t.DriverCommonNavigation.Id,
                    Status = t.DriverCommonNavigation.Status,
                    License = t.DriverCommonNavigation.License,
                    Situation = t.DriverCommonNavigation.Situation,
                    SituationNavigation = t.DriverCommonNavigation.SituationNavigation == null? null : new Situation() {
                        Id = t.DriverCommonNavigation.SituationNavigation.Id,
                        Name = t.DriverCommonNavigation.SituationNavigation.Name,
                        Description = t.DriverCommonNavigation.SituationNavigation.Description
                    }
                },
                EmployeeNavigation = t.EmployeeNavigation == null? null : new Employee() {
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
                    IdentificationNavigation = t.EmployeeNavigation.IdentificationNavigation == null? null : new Identification() {
                        Id = t.EmployeeNavigation.IdentificationNavigation.Id,
                        Status = t.EmployeeNavigation.IdentificationNavigation.Status,
                        Name = t.EmployeeNavigation.IdentificationNavigation.Name,
                        FatherLastname = t.EmployeeNavigation.IdentificationNavigation.FatherLastname,
                        MotherLastName = t.EmployeeNavigation.IdentificationNavigation.MotherLastName,
                        Birthday = t.EmployeeNavigation.IdentificationNavigation.Birthday
                    }
                }
                
            });


            }
        return await Drivers.View(Options, include);
    }
}
