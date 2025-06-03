using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validations.Validators;

namespace TWS_Business;

/// <summary>
///     
/// </summary>
/// <typeparam name="InternalT"></typeparam>
/// <typeparam name="ExternalT"></typeparam>
public abstract class CommonEntity<InternalT, ExternalT>
    : BEntity
    where InternalT : class, IEntity
    where ExternalT : class, IEntity {

    [Relation, ExclusiveValidator]
    public virtual InternalT? Internal { get; set; }

    [Relation, ExclusiveValidator]
    public virtual ExternalT? External { get; set; }
}


/// <summary>
/// 
/// </summary>
/// <typeparam name="TCommon"></typeparam>
public abstract class CommonEntityEdge<TCommon>
    : BEntity
    where TCommon : class, IEntity {

    /// <summary>
    ///     <typeparamref name="TCommon"/> information.
    /// </summary>
    [Relation]
    public virtual TCommon Common { get; set; } = default!;
}

/// <summary>
/// 
/// </summary>
public abstract class BEntity
    : CSM_Foundation.Database.Bases.BEntity {

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