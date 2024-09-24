using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="CarriersDepot"/>.
/// </summary>
public class Q_CarriersDepot
    : BQ_Depot<Carrier, CarriersDepot, TWSBusinessDatabase> {
    public Q_CarriersDepot()
        : base(nameof(Carrier.Id)) {
    }

    protected override Carrier MockFactory(string RandomSeed) {

        return new() {
            Name = "Carrier name",
            Approach = 1,
            Address = 1,
            Status = 1,
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Carrier Mock) 
    => (nameof(Carrier.Name), Mock.Name);
}