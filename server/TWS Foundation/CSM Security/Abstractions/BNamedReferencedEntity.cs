using System.Text.Json.Serialization;


namespace CSM_Security.Abstractions;

/// <summary>
///     Represents a { CSM Security } named referenced entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { CSM Security } entities.
/// </remarks>
/// 

public class BNamedReferencedEntity
    : CSM_Foundation.Database.Entity.Bases.BNamedReferencedEntity
{
    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}
