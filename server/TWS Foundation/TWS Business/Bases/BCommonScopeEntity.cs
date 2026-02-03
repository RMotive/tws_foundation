using System.Text.Json.Serialization;

using CSM_Database_Core.Entities.Abstractions.Bases;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

namespace TWS_Business.Bases;

/// <summary>
///     Represents a { TWS Business } common scope entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public abstract class BCommonScopeEntity<TCommonEntity>
    : PartnerScopeEntityBase<TCommonEntity>
   where TCommonEntity : IPartnerBridgeEntity {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}

