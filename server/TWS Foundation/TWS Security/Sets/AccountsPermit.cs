namespace TWS_Security.Sets;

public partial class AccountsPermit {
    public int Account { get; set; }

    public int Permit { get; set; }

    public virtual Account AccountNavigation { get; init; } = null!;

    public virtual Permit PermitNavigation { get; init; } = null!;
}
