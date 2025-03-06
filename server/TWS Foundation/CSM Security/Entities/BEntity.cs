namespace CSM_Security.Entities;

/// <summary>
///     
/// </summary>
public abstract class BEntity
    : CSM_Foundation.Database.Bases.BEntity {

    public override Type Database { get; init; } = typeof(Database);
}
