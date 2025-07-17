using System.Text.Json.Serialization;

using CSM_Foundation.Database.Entity.Bases;

namespace TWS_Business.Bases;

/// <summary>
///     Represents a { TWS Business } common entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public abstract class BCommonEntity<TInternal, TExternal>
    : CSM_Foundation.Database.Entity.Bases.BCommonEntity<TInternal, TExternal>
    where TInternal : ICommonScopeEntity 
    where TExternal : ICommonScopeEntity {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}

