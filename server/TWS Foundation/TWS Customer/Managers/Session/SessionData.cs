using System.Text.Json.Serialization;

using CSM_Security.Entities;

namespace TWS_Customer.Managers.Session;

/// <summary>
///     {model} Implementation for a server session authenitcated information, storing relevant data about a session scope for an specific user.
/// </summary>
public record SessionData {

    /// <summary>
    ///     Unique session token.
    /// </summary>
    public required Guid Token { get; set; }

    /// <summary>
    ///     Whether the current session has free master access.
    /// </summary>
    public required bool Wildcard { get; set; }

    /// <summary>
    ///     When this session usage gets expired.
    /// </summary>
    public required DateTime Expiration { get; set; }

    /// <summary>
    ///     User contact information.
    /// </summary>
    public required Contact Contact { get; set; }

    /// <summary>
    ///     {Server Side} account scope data.
    /// </summary>
    [JsonIgnore]
    public Account Account { get; init; } = default!;
}