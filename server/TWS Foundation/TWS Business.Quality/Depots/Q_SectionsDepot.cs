using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="SectionsDepot"/>.
/// </summary>
public class Q_SectionsDepot
    : BQ_Depot<Section, SectionsDepot, BusinessDatabase> {

    public Q_SectionsDepot()
        : base(nameof(Section.Id)) {
    }

    protected override Section MockFactory(string RandomSeed) {

        return new() {
            Name = "Section A name",
            Status = new Status { Id = 1 },
            Yard = new Location { Id = 1 },
            Capacity = 20,
            Ocupancy = 10
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Section Mock) {
        return (nameof(Section.Name), Mock.Name);
    }
}