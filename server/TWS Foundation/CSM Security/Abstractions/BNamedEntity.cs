using System.Text.Json.Serialization;

namespace CSM_Security.Abstractions;

/// <summary>
///     Represents a { CSM Security } named entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { CSM Security } entities.
/// </remarks>
public abstract class BNamedEntity
    : CSM_Foundation.Database.Entity.Bases.BNamedEntity {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}
