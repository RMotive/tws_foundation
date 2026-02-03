using System.Text.Json.Serialization;

using CSM_Database_Core.Entities.Abstractions.Bases;

namespace CSM_Security.Abstractions;

/// <summary>
///     Represents a { CSM Security } named entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { CSM Security } entities.
/// </remarks>
public abstract class BNamedEntity
    : NamedEntityBase {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}
