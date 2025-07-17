using System.Text.Json.Serialization;

namespace TWS_Business.Bases;

/// <summary>
///     Represents a { TWS Business } entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public abstract class BEntity
    : CSM_Foundation.Database.BEntity {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}

