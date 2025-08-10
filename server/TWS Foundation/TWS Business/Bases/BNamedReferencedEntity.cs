
using System.Text.Json.Serialization;

namespace TWS_Business.Bases;


/// <summary>
///     Represents a { TWS Business } named referenced entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public class BNamedReferencedEntity 
    : CSM_Foundation.Database.Entity.Bases.BNamedReferencedEntity {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}
