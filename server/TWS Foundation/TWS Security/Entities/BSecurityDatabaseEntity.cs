using CSM_Foundation.Database.Bases;

namespace TWS_Security.Entities;

public abstract class BSecurityDatabaseEntity
    : BEntity {

    public override Type Database { get; init; } = typeof(SecurityDatabase);
}
