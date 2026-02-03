using System.Text.Json.Serialization;

using CSM_Database_Core.Entities.Abstractions.Bases;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

namespace TWS_Business.Bases;

/// <summary>
///     Represents a { TWS Business } common entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public abstract class BCommonEntity<TInternal, TExternal>
    : PartnerBridgeEntityBase<TInternal, TExternal>
    where TInternal : IPartnerScopeEntity
    where TExternal : IPartnerScopeEntity {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}

