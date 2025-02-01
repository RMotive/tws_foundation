
using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Security.Depots;
using TWS_Security.Sets;

namespace TWS_Security.Quality.Depots;

/// <summary>
///     Qualifies the <see cref="PermitsDepot"/>.
/// </summary>
public class Q_PermitsDepot
    : BQ_Depot<Permit, PermitsDepot, TWSSecurityDatabase> {
    public Q_PermitsDepot()
        : base(nameof(Permit.Reference)) {
    }

    protected override Permit MockFactory(string RandomSeed) {
        return new() {
            Solution = 0,
            Feature = 0,
            Action = 0,
            Reference = RandomUtils.String(8),
            Enabled = true,
            SolutionNavigation = new() {
                Name = RandomSeed,
                Sign = RandomUtils.String(5),
            },
            FeatureNavigation = new() {
                Name = RandomUtils.String(25),
                Enabled = true,
            },
            ActionNavigation = new() {
                Name = RandomUtils.String(25),
                Enabled = true,
            },
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Permit Mock) 
    => (nameof(Permit.Reference), Mock.Reference);
}
