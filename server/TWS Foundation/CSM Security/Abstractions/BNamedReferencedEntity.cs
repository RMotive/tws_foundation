using System.Text.Json.Serialization;

using CSM_Database_Core.Entities.Abstractions.Bases;


namespace CSM_Security.Abstractions;

/// <summary>
///     Represents a { CSM Security } named referenced entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { CSM Security } entities.
/// </remarks>
/// 

public class BNamedReferencedEntity
    : CatalogEntityBase
{
    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}
