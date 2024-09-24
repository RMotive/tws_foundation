using TWS_Security.Sets;

namespace TWS_Customer.Managers.Records;
public record Session {
    public required Guid Token { get; init; }
    public required DateTime Expiration { get; init; }
    public required string Identity { get; init; }
    public required bool Wildcard { get; init; }
    public required Permit[] Permits { get; init; }
    public required Contact Contact { get; init; }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public Session Copy(Guid? Token = null, DateTime? Expiration = null, string? Identity = null, bool? Wildcard = null, Permit[]? Permits = null, Contact? Contact = null) {
        return new Session {
            Token = Token ?? this.Token,
            Expiration = Expiration ?? this.Expiration,
            Identity = Identity ?? this.Identity,
            Wildcard = Wildcard ?? this.Wildcard,
            Permits = Permits ?? this.Permits,
            Contact = Contact ?? this.Contact
        };
    }
}
