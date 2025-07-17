using System.Text.Json.Serialization;

using CSM_Foundation.Database.Entity.Bases;

namespace TWS_Business.Bases;

/// <summary>
///     Represents a { TWS Business } common scope entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public abstract class BCommonScopeEntity<TCommonEntity>
    : CSM_Foundation.Database.Entity.Bases.BCommonScopeEntity<TCommonEntity>
   where TCommonEntity : ICommonEntity {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}

