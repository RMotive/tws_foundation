using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="SectionsDepot"/>.
/// </summary>
public class Q_SectionsDepot
    : BQ_Depot<Section, SectionsDepot, TWSBusinessDatabase> {
    public Q_SectionsDepot()
        : base(nameof(Section.Id)) {
    }

    protected override Section MockFactory(string RandomSeed) {

        return new() {
            Name = "Section A name",
            Status = 1,
            Yard = 1,
            Capacity = 20,
            Ocupancy = 10
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Section Mock) {
        return (nameof(Section.Name), Mock.Name);
    }
}