using System.Collections.Generic;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Security;
using TWS_Security.Depots;
using TWS_Security.Sets;

namespace TWS_Customer.Services;
/// <summary>
/// 
/// </summary>
public class AccountsService
    : IAccountsService {
    /// <summary>
    /// 
    /// </summary>
    private readonly AccountsDepot Accounts;
    private readonly TWSSecurityDatabase Database;
    protected readonly IDisposer? Disposer;
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Solutions"></param>
    public AccountsService(AccountsDepot Accounts, TWSSecurityDatabase Database, IDisposer? Disposer) {
        this.Accounts = Accounts;
        this.Database = Database;
        this.Disposer = Disposer;
    }

    private IQueryable<Account> Include(IQueryable<Account> query) {
        return query
        .Select(t => new Account() {
            Id = t.Id,
            Timestamp = t.Timestamp,
            User = t.User,
            Contact = t.Contact,
            Password = t.Password,
            ContactNavigation = t.ContactNavigation == null ? null : new Contact() {
                Id = t.ContactNavigation.Id,
                Timestamp = t.ContactNavigation.Timestamp,
                Name = t.ContactNavigation.Name,
                Lastname = t.ContactNavigation.Lastname,
                Email = t.ContactNavigation.Email,
                Phone = t.ContactNavigation.Phone
            },
            AccountPermits = t.AccountPermits.Where(p => p.Account == t.Id).Select(p => new AccountPermit() {
                Account = p.Account,
                Permit = p.Permit,
                PermitNavigation = p.PermitNavigation != null ? new Permit() {
                    Id = p.PermitNavigation.Id,
                    Timestamp = p.PermitNavigation.Timestamp,
                    Solution = p.PermitNavigation.Solution,
                    Feature = p.PermitNavigation.Feature,
                    Action = p.PermitNavigation.Action,
                    Reference = p.PermitNavigation.Reference,
                    Enabled = p.PermitNavigation.Enabled,
                    FeatureNavigation = p.PermitNavigation.FeatureNavigation != null ? new Feature() {
                        Id = p.PermitNavigation.FeatureNavigation.Id,
                        Timestamp = p.PermitNavigation.FeatureNavigation.Timestamp,
                        Name = p.PermitNavigation.FeatureNavigation.Name,
                        Description = p.PermitNavigation.FeatureNavigation.Description,
                        Enabled = !p.PermitNavigation.Enabled,
                    } : null,
                    ActionNavigation = p.PermitNavigation.ActionNavigation != null ? new TWS_Security.Sets.Action() {
                        Id = p.PermitNavigation.ActionNavigation.Id,
                        Timestamp = p.PermitNavigation.ActionNavigation.Timestamp,
                        Name = p.PermitNavigation.ActionNavigation.Name,
                        Description = p.PermitNavigation.ActionNavigation.Description,
                        Enabled = p.PermitNavigation.ActionNavigation.Enabled,
                    } : null,
                    SolutionNavigation = p.PermitNavigation.SolutionNavigation != null? new Solution() {
                        Id = p.PermitNavigation.SolutionNavigation.Id,
                        Timestamp = p.PermitNavigation.SolutionNavigation.Timestamp,
                        Name = p.PermitNavigation.SolutionNavigation.Name,
                        Sign = p.PermitNavigation.SolutionNavigation.Sign,
                        Description = p.PermitNavigation.SolutionNavigation.Description,
                    } : null,
                } : null,
            }).ToList(),
            AccountProfiles = t.AccountProfiles.Where(p => p.Account == t.Id).Select(p => new AccountProfile() {
                Account = p.Account,
                Profile = p.Profile,
                ProfileNavigation = p.ProfileNavigation != null ? new Profile() {
                    Id = p.ProfileNavigation.Id,
                    Timestamp = p.ProfileNavigation.Timestamp,
                    Name = p.ProfileNavigation.Name,
                    Description = p.ProfileNavigation.Description,
                } : null,
            }).ToList(),
        });
    }
    private ICollection<AccountProfile> EvaluateCollections(ICollection<AccountProfile> Original, ICollection<AccountProfile> Updated) {
        // Filtering data
        ICollection<AccountProfile> added = Updated.Except(Original).ToList();
        ICollection<AccountProfile> removed = Original.Except(Updated).ToList();
        // Removing the original reference
        ICollection<AccountProfile> result = [.. Original];

        // Adding profiles to account
        foreach (AccountProfile profile in added) {
            result.Add(profile);
        }

        // Removing missing profiles from account
        foreach (AccountProfile profile in removed) {
            profile.ProfileNavigation = null;
            result.Remove(profile);
            Database.Remove(profile);
        }

        return result;
    }
    private ICollection<AccountPermit> EvaluateCollections(ICollection<AccountPermit> Original, ICollection<AccountPermit> Updated) {

        // Filtering data
        ICollection<AccountPermit> added = Updated.Except(Original).ToList();
        ICollection<AccountPermit> removed = Original.Except(Updated).ToList();
        // Removing the original reference
        ICollection<AccountPermit> result = [.. Original];

        // Adding new permits to account
        foreach (AccountPermit permit in added) {
            if(permit.Permit != 0) permit.PermitNavigation = null;
            result.Add(permit);
        }
        
        // Removing missing permits from account
        foreach (AccountPermit permit in removed) {
            permit.PermitNavigation = null;
            result.Remove(permit);
            Database.Remove(permit);
        }
   
        return result;
    }

    public async Task<SetViewOut<Permit>> GetPermits(Account Account) {
        return new SetViewOut<Permit>() {
            Page = 0,
            Pages = 0,
            Records = 0,
            Amount = 0,
            Sets = await Accounts.GetPermits(Account.Id),
        };
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    public async Task<SetViewOut<Account>> View(SetViewOptions<Account> Options) {
        return await Accounts.View(Options, Include);
    }

    public async Task<SetBatchOut<Account>> Create(Account[] accounts) {
        /// Removing navigation trackers.
        foreach(Account account in accounts) {
            foreach(AccountPermit ap in account.AccountPermits) {
                if(ap.PermitNavigation != null && ap.PermitNavigation.Id > 0) {
                    ap.PermitNavigation = null;
                } else {
                    Permit? permit = ap.PermitNavigation;
                    if (permit?.ActionNavigation != null && permit.ActionNavigation.Id > 0) permit.ActionNavigation = null;
                    if (permit?.FeatureNavigation != null && permit.FeatureNavigation.Id > 0) permit.FeatureNavigation = null;
                    if (permit?.SolutionNavigation != null && permit.SolutionNavigation.Id > 0) permit.SolutionNavigation = null;
                }
            }
        }

        return await Accounts.Create(accounts);
    }

    public async Task<RecordUpdateOut<Account>> Update(Account Account) {
        // Evaluate record.
        Account.EvaluateWrite();
        // Check if the Account currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        Account? current = await Include(Database.Accounts)
            .Where(i => i.Id == Account.Id)
            .FirstOrDefaultAsync();

        // If Account not exist in database, then use the generic update method.
        if (current == null) {
            return await Accounts.Update(Account, Include);
        }
        // Save a deep copy before changes.
        Account previousDeepCopy = current.DeepCopy();

        // Clear the navigation to avoid duplicated tracking issues.

        current.ContactNavigation = null;
        current.AccountPermits = [];
        current.AccountProfiles = [];

        Database.Attach(current);

        // Update the main model properties.
        EntityEntry previousEntry = Database.Entry(current);
        previousEntry.CurrentValues.SetValues(Account);

        // ---> Update Location Navigation
        if (Account.ContactNavigation != null) {
            current.Contact = Account.ContactNavigation.Id;
            current.ContactNavigation = Account.ContactNavigation;
        }

       // Calculte the add/remove permits actions.
       current.AccountPermits = EvaluateCollections(previousDeepCopy.AccountPermits, Account.AccountPermits);
       current.AccountProfiles = EvaluateCollections(previousDeepCopy.AccountProfiles, Account.AccountProfiles);

        await Database.SaveChangesAsync();
        Disposer?.Push(Database, Account);

        // Get the lastest record data from database.
        Account? lastestRecord = await Include(Database.Accounts)
            .Where(i => i.Id == Account.Id)
            .FirstOrDefaultAsync();

        return new RecordUpdateOut<Account> {
            Previous = previousDeepCopy,
            Updated = lastestRecord ?? Account,
        };
    }
    public async Task<Account> Delete(Account Account) {
        //Removing one to many relationships.
        List<AccountPermit> accountPermits = [.. Database.AccountsPermits.Where(ap => ap.Account == Account.Id)];
        List<AccountProfile> accountProfiles = [.. Database.AccountsProfiles.Where(ap => ap.Account == Account.Id)];
        Database.RemoveRange(accountPermits);
        Database.RemoveRange(accountProfiles);

        Contact? contact = await Database.Contacts.Where(e => e.Id == Account.Contact).FirstOrDefaultAsync();
        if(contact != null) Database.Remove(contact);

        return await Accounts.Delete(Account);
    }

}
