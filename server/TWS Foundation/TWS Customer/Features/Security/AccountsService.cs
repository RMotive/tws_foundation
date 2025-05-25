using CSM_Foundation.Customer;

using CSM_Security.Depots;
using CSM_Security.Entities;

namespace TWS_Customer.Features.Security;

/// <summary>
///     [Interface] for <see cref="Account"/> based [Service] implementations.
/// </summary>
public interface IAccountsService
    : IService<Account> {

}

/// <summary>
///     [Service] implementation for <see cref="Account"/> based operations.
/// </summary>
public class AccountsService
    : BService<Account, IAccountsDepot>, IAccountsService {

    /// <summary>
    ///     Creates a new <see cref="AccountsService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Account"/> based [Depot] handler to be used.
    /// </param>
    public AccountsService(IAccountsDepot Depot) : base(Depot) { }
}
