namespace TWS_Security.Sets;


public class AccountProfile {
    public required int Account { get; init; }
    public required int Profile { get; init; }

    public virtual Account AccountNavigation { get; init; } = null!;
    public virtual Profile ProfileNavigation { get; init; } = null!;
}
