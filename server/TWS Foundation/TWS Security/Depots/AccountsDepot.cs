﻿using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;

using Microsoft.EntityFrameworkCore;

using TWS_Security.Depots.Interfaces;
using TWS_Security.Sets;

namespace TWS_Security.Depots;
/// <summary>
///     Implements a new depot to handle <see cref="Account"/> entity
///     transactions. 
/// </summary>
public class AccountsDepot
    : BDatabaseDepot<TWSSecuritySource, Account>
    , IAccountsDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Account"/>.
    /// </summary>
    public AccountsDepot(TWSSecuritySource Source, IMigrationDisposer? Disposer = null)
        : base(Source, Disposer) {
    }
    /// <summary>
    ///     Generates a new depot handler for <see cref="Account"/>.
    /// </summary>
    public AccountsDepot()
        : base(new(), null) {
    }


    public async Task<Permit[]> GetPermits(int Account) {
        IQueryable<AccountsPermit> accountPermits = Source.AccountsPermits
            .Where(i => i.Account == Account)
            .Include(i => i.PermitNavigation);

        IQueryable<Permit> permits = accountPermits
            .Select(i => i.PermitNavigation);

        return await permits.ToArrayAsync();
    }
}
