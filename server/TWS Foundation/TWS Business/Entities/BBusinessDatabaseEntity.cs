using CSM_Foundation.Database.Bases;

namespace TWS_Business.Entities;

public abstract class BBusinessDatabaseEntity
    : BEntity {

    public override Type Database { get; init; } = typeof(BusinessDatabase);
}
