using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="IdentificationsDepot"/>.
/// </summary>
public class Q_IdentificationsDepot
    : BQ_Depot<Identification, IdentificationsDepot, TWSBusinessDatabase> {
    public Q_IdentificationsDepot()
        : base(nameof(Identification.Id)) {
    }

    protected override Identification MockFactory(string RandomSeed) {

        return new() {
            Name = "Identifications name",
            Status = 1,
            FatherLastname = "Father last name",
            MotherLastName = "Mother last name"
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Identification Mock) {
        return (nameof(Identification.Name), Mock.Name);
    }
}