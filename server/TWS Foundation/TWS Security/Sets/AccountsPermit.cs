using System.ComponentModel.DataAnnotations.Schema;

namespace TWS_Security.Sets;

[Table("Accounts_Permits")]
public partial class AccountsPermit {
    public int Account { get; set; }

    public int Permit { get; set; }

    public virtual Account AccountNavigation { get; set; } = null!;

    public virtual Permit PermitNavigation { get; set; } = null!;
}
