﻿using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="EmployeesDepot"/>.
/// </summary>
public class Q_EmployeesDepot
    : BQ_Depot<Employee, EmployeesDepot, TWSBusinessDatabase> {
    public Q_EmployeesDepot()
        : base(nameof(Employee.Id)) {
    }

    protected override Employee MockFactory(string RandomSeed) {

        return new() {
            Identification = 1,
            Status = 1,
            Approach = 1,
            Address = 1,
            Curp = RandomUtils.String(18),
            Rfc = RandomUtils.String(12),
            Nss = RandomUtils.String(11)
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Employee Mock) 
    => (nameof(Employee.Curp), Mock.Curp);
}