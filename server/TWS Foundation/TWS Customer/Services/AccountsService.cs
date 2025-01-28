using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

using TWS_Business;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Security;
using TWS_Security.Depots;
using TWS_Security.Sets;

using static System.Collections.Specialized.BitVector32;

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
            User = t.User,
            Contact = t.Contact,
            Password = t.Password,
            ContactNavigation = t.ContactNavigation == null ? null : new Contact() {
                Id = t.ContactNavigation.Id,
                Name = t.ContactNavigation.Name,
                Lastname = t.ContactNavigation.Lastname,
                Email = t.ContactNavigation.Email,
                Phone = t.ContactNavigation.Phone
            }
        });
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    public async Task<SetViewOut<Account>> View(SetViewOptions<Account> Options) {
        return await Accounts.View(Options, Include);
    }

    public Task<SetBatchOut<Account>> Create(Account[] accounts) {
        return this.Accounts.Create(accounts);
    }

    public async Task<RecordUpdateOut<Account>> Update(Account Account) {
        // Evaluate record.
        Account.EvaluateWrite();
        // Check if the trailer currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        Account? current = await Include(Database.Accounts)
            .Where(i => i.Id == Account.Id)
            .FirstOrDefaultAsync();

        // If trailer not exist in database, then use the generic update method.
        if (current == null) {
            return await Accounts.Update(Account, Include);
        }
        // Save a deep copy before changes.
        Account previousDeepCopy = current.DeepCopy();

        // Clear the navigation to avoid duplicated tracking issues.

        current.ContactNavigation = null;

        Database.Attach(current);

        // Update the main model properties.
        EntityEntry previousEntry = Database.Entry(current);
        previousEntry.CurrentValues.SetValues(Account);

        // ---> Update Location Navigation
        if (Account.ContactNavigation != null) {
            current.Contact = Account.ContactNavigation.Id;
            current.ContactNavigation = Account.ContactNavigation;
        }

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
}
