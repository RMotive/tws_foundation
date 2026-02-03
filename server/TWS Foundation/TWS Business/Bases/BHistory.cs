using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation.Database;

namespace TWS_Business.Bases;

/// <summary>
///     Represents a { TWS Business } history entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public class BHistory<TEntity>
    : CSM_Foundation.Database.Entity.Bases.BHistory<TEntity>
    where TEntity : class, IEntity {

    public override Type Database { get; init; } = typeof(Database);
}
