using System.ComponentModel;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="DriversDepot"/>.
/// </summary>
public class Q_DriversDepot
    : BQ_Depot<Driver, DriversDepot, TWSBusinessDatabase> {
    public Q_DriversDepot()
        : base(nameof(Driver.Id)) {
    }

    protected override Driver MockFactory(string RandomSeed) {

        return new() {
           Status = 1,
           Employee = 1,
           DriverType = RandomUtils.String(12),
           Common = 0,
           DriverCommonNavigation = new() {
               Timestamp = DateTime.Now,
               Status = 1,
               License = RandomUtils.String(12)
           }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Driver Mock) 
    => null;
}