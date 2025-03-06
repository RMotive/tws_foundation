using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Entities.Trailers;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailerClassesDepot"/>.
/// </summary>
public class Q_TrailerClassesDepot
    : BQ_Depot<Trailer_Class, TrailerClassesDepot, BusinessDatabase> {
    public Q_TrailerClassesDepot()
        : base(nameof(Trailer_Class.Id)) {
    }

    protected override Trailer_Class MockFactory(string RandomSeed) {

        return new() {
            Name = "Trailer Class name",
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Trailer_Class Mock) {
        return (nameof(Trailer_Class.Name), Mock.Name);
    }
}