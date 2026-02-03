using System.Text.Json.Serialization;

using CSM_Database_Core.Entities.Abstractions.Bases;

namespace TWS_Business.Bases;

/// <summary>
///     Represents a { TWS Business } named entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public abstract class BNamedEntity
    : NamedEntityBase {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}
