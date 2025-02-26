using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities;

/// <summary>
/// 
/// </summary>
/// <typeparam name="TCommon"></typeparam>
public abstract class BBusinessEntity<TCommon>
    : BEntity<TCommon>
    where TCommon : class, IEntity {
    public override Type Database { get; init; } = typeof(BusinessDatabase);
}

/// <summary>
/// 
/// </summary>
public abstract class BBusinessEntity
    : BEntity {

    public override Type Database { get; init; } = typeof(BusinessDatabase);
}
