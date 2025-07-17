using System.Text.Json.Serialization;

namespace TWS_Business.Bases;

/// <summary>
///     Represents a { TWS Business } named entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public abstract class BNamedEntity
    : CSM_Foundation.Database.Entity.Bases.BNamedEntity {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}
