

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class EmployeesService : IEmployeesService {
    private readonly EmployeesDepot EmployeesDepot;

    public EmployeesService(EmployeesDepot EmployeeDepot) {
        this.EmployeesDepot = EmployeeDepot;
    }

    public async Task<SetViewOut<Employee>> View(SetViewOptions<Employee> Options) {
        static IQueryable<Employee> include(IQueryable<Employee> query) {
            return query
                .Select(p => new Employee {
                   Id = p.Id,
                   Timestamp = p.Timestamp,
                   Status = p.Status,
                   Identification = p.Identification,
                   Address = p.Address,
                   Approach = p.Approach,
                   Curp = p.Curp,
                   AntecedentesNoPenaleseExp = p.AntecedentesNoPenaleseExp,
                   Rfc = p.Rfc,
                   Nss = p.Nss,
                   IMSSRegistrationDate = p.IMSSRegistrationDate,
                   HiringDate = p.HiringDate,
                   TerminationDate = p.TerminationDate,
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
                   ApproachNavigation = p.ApproachNavigation == null ? null : new Approach() {
                        Id = p.ApproachNavigation.Id,
                        Timestamp = p.ApproachNavigation.Timestamp,
                        Status = p.ApproachNavigation.Status,
                        Enterprise = p.ApproachNavigation.Enterprise,
                        Personal = p.ApproachNavigation.Personal,
                        Alternative = p.ApproachNavigation.Alternative,
                        Email = p.ApproachNavigation.Email,
                   },
                   IdentificationNavigation = p.IdentificationNavigation == null? null : new Identification() {
                       Id = p.IdentificationNavigation.Id,
                       Timestamp = p.IdentificationNavigation.Timestamp,
                       Status = p.IdentificationNavigation.Status,
                       Name = p.IdentificationNavigation.Name,
                       FatherLastname = p.IdentificationNavigation.FatherLastname,
                       MotherLastName = p.IdentificationNavigation.MotherLastName,
                       Birthday = p.IdentificationNavigation.Birthday,
                   },
                });

        }
        return await EmployeesDepot.View(Options, include);
    }
}
