using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="IdentificationsDepot"/>.
/// </summary>
public class Q_IdentificationsDepot
    : BQ_Depot<Identification, IdentificationsDepot, Database> {
    public Q_IdentificationsDepot()
        : base(nameof(Identification.Id)) {
    }

    protected override Identification MockFactory(string RandomSeed) {
        return new() {
            Name = RandomSeed,
            Status = new Status { Id = 1 },
            Lastname = $"{RandomSeed[..8]}  {RandomSeed[8..]}",
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Identification Mock) {
        return (nameof(Identification.Name), Mock.Name);
    }
}