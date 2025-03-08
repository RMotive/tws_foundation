using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Approaches;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="CarriersDepot"/>.
/// </summary>
public class Q_CarriersDepot
    : BQ_Depot<Carrier, CarriersDepot, Database> {
    public Q_CarriersDepot()
        : base(nameof(Carrier.Id)) {
    }

    protected override Carrier MockFactory(string RandomSeed) {

        return new() {
            Name = "Carrier name",
            Approach = new Approach {
                Id = 1,
            },
            Address = new Address {
                Id = 1,
            },
            Status = new Status {
                Id = 1,
            },
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Carrier Mock) {
        return (nameof(Carrier.Name), Mock.Name);
    }
}