using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="AxesDepot"/>.
/// </summary>
public class Q_AxesDepot
    : BQ_MigrationDepot<Axis, AxesDepot, TWSBusinessDatabase> {
    public Q_AxesDepot()
        : base(nameof(Axis.Id)) {
    }

    protected override Axis MockFactory() {

        return new() {
            Name = "Axis name",
            Quantity = 1
        };
    }
}