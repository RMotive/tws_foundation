
using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Security.Depots;
using TWS_Security.Sets;

namespace TWS_Security.Quality.Depots;

/// <summary>
///     Qualifies the <see cref="ProfilesDepot"/>.
/// </summary>
public class Q_ProfilesDepot
    : BQ_Depot<Profile, ProfilesDepot, TWSSecurityDatabase> {
    public Q_ProfilesDepot()
        : base(nameof(Profile.Name)) {
    }

    protected override Profile MockFactory(string RandomSeed) {
        return new() {
            Name = RandomSeed,
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Profile Mock) 
    => (nameof(Profile.Name), Mock.Name);
}
