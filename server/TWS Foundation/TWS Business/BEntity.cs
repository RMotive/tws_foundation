using System.Text.Json.Serialization;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Bases;
using CSM_Foundation.Database.Validations.Validators;

using TWS_Business.Entities;

namespace TWS_Business;

/// <summary>
///     
/// </summary>
/// <typeparam name="TInternal"></typeparam>
/// <typeparam name="TExternal"></typeparam>
public abstract class CommonEntity<TInternal, TExternal>
    : BEntity
    where TInternal : class, IEntity
    where TExternal : class, IEntity {

    [Relation, ExclusiveValidator]
    public TInternal? Internal { get; set; }

    [Relation, ExclusiveValidator]
    public TExternal? External { get; set; }
}


/// <summary>
/// 
/// </summary>
/// <typeparam name="TCommonEntity"></typeparam>
public abstract class CommonEntityEdge<TCommonEntity>
    : BEntity
    where TCommonEntity : class, IEntity {

    /// <summary>
    ///     <typeparamref name="TCommonEntity"/> information.
    /// </summary>
    [Relation]
    public TCommonEntity Common { get; set; } = default!;
}

/// <summary>
/// 
/// </summary>
public abstract class BEntity
    : CSM_Foundation.Database.BEntity {

    [JsonIgnore]
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