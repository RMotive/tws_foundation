using CSM_Foundation.Product;

using CSM_Security.Depots;
using CSM_Security.Entities;

namespace TWS_Customer.Features.Security;

/// <summary>
///     [Interface] for <see cref="Profile"/> based [Service] implementations.
/// </summary>
public interface IProfilesService
    : IService<Profile> {
}

/// <summary>
///     [Service] implementation for <see cref="Profile"/> based operations.
/// </summary>
public class ProfilesService
    : BService<Profile, IProfilesDepot>, IProfilesService {

    /// <summary>
    ///     Creates a new <see cref="ProfilesService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Profile"/> based [Depot] handler to be used.
    /// </param>
    public ProfilesService(IProfilesDepot Depot) : base(Depot) { }
}
