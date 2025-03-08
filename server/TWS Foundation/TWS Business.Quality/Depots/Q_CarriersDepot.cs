using CSM_Foundation.Database.Quality;

using TWS_Business.Depots.Vehicules;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Depots;

/// <summary>
///     Qualifies the <see cref="CarriersDepot"/>.
/// </summary>
public class Q_CarriersDepot
    : BQ_Depot<Carrier, CarriersDepot, Database> {

    protected override Carrier EntityFactory(string Entropy) {

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
}