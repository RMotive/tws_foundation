using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailerClassesDepot"/>.
/// </summary>
public class Q_TrailerClassesDepot
    : BQ_Depot<TrailerClass, TrailerClassesDepot, TWSBusinessDatabase> {
    public Q_TrailerClassesDepot()
        : base(nameof(TrailerClass.Id)) {
    }

    protected override TrailerClass MockFactory(string RandomSeed) {

        return new() {
            Name = "Trailer TrailerClass name",
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(TrailerClass Mock) {
        return (nameof(TrailerClass.Name), Mock.Name);
    }
}