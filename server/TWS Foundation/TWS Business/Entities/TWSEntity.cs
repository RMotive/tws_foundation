using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities;

/// <summary>
///     
/// </summary>
/// <typeparam name="InternalT"></typeparam>
/// <typeparam name="ExternalT"></typeparam>
public abstract class TWSScopeCommonEntity<InternalT, ExternalT>
    : TWSEntity
    where InternalT : class, IEntity
    where ExternalT : class, IEntity {
}


/// <summary>
/// 
/// </summary>
/// <typeparam name="TCommon"></typeparam>
public abstract class TWSScopeEntity<TCommon>
    : BEntity<TCommon>
    where TCommon : class, IEntity {

    public override Type Database { get; init; } = typeof(Database);
}

/// <summary>
/// 
/// </summary>
public abstract class TWSEntity
    : BEntity {

    public override Type Database { get; init; } = typeof(Database);
}

/// <summary>
/// 
/// </summary>
/// <typeparam name="TEntity"></typeparam>
public abstract class TWSHistory<TEntity>
    : BHistory<TEntity>
    where TEntity : class, IEntity {

    public override Type Database { get; init; } = typeof(Database);
}