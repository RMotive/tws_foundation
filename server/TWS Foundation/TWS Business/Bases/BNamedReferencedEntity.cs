
namespace TWS_Business.Bases;


/// <summary>
///     Represents a { TWS Business } named referenced entity implementation. 
/// </summary>
/// <remarks>
///     Usage must be exclusively for { TWS Business } entities.
/// </remarks>
public class BNamedReferencedEntity 
    : CSM_Foundation.Database.Entity.Bases.BNamedReferencedEntity {

    public override Type Database { get; init; } = typeof(Database);
}
