using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using Microsoft.EntityFrameworkCore.Metadata.Internal;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="CarriersHDepot"/>.
/// </summary>
public class Q_CarriersHDepot
    : BQ_Depot<CarrierH, CarriersHDepot, TWSBusinessDatabase> {
    public Q_CarriersHDepot()
        : base(nameof(CarrierH.Entity)) {
    }

    protected override CarrierH MockFactory(string RandomSeed) {

        return new() {
            Sequence = 1,
            //Timemark = DateTime.Now,
            Status = 1,
            Entity = 1,
            Name = "Carriers H name",
            Address = 1
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(CarrierH Mock) 
    => null;
}
