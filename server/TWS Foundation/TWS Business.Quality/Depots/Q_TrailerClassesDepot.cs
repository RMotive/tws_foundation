using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailerClassesDepot"/>.
/// </summary>
public class Q_TrailerClassesDepot
    : BQ_Depot<TrailerClass, TrailerClassesDepot, BusinessDatabase> {
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