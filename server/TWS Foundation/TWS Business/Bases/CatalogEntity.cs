
using System.Text.Json.Serialization;

using CSM_Database_Core.Entities.Abstractions.Bases;

namespace TWS_Business.Bases;

/// <summary>
///     Represents a { TWS Business } named referenced entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public class CatalogEntity 
    : CatalogEntityBase {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}
