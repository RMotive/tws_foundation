namespace CSM_Foundation.Database.Entity.Bases;

/// <summary>
///     Represents an <see cref="IEntity"/> that holds a scope between internal ( tenant business entities data ) and external ( tenant partners entities data ).
/// </summary>
public interface ICommonEntity
    : IEntity {
}

/// <summary>
///     Represents an <see cref="IEntity"/> that holds a scope between internal ( tenant business entities data ) and external ( tenant partners entities data ).
/// </summary>
/// <typeparam name="TInternal"> 
///     Type of the <see cref="IEntity"/> that represents the internal data model.
/// </typeparam>
/// <typeparam name="TExternal">
///     Type of the <see cref="IEntity"/> that represents the external data model.
/// </typeparam>
public interface ICommonEntity<TInternal, TExternal>
    : ICommonEntity
    where TInternal : ICommonScopeEntity
    where TExternal : ICommonScopeEntity {

    /// <summary>
    ///     <typeparamref name="TInternal"/> data.
    /// </summary>
    public TInternal? Internal { get; set; }

    /// <summary>
    ///     <typeparamref name="TExternal"/> data.
    /// </summary>
    public TExternal? External { get; set; }
}

/// <summary>
///     Represents an <see cref="IEntity"/> that holds a scope between internal ( tenant business entities data ) and external ( tenant partners entities data ).
/// </summary>
/// <typeparam name="TInternal"> 
///     Type of the <see cref="IEntity"/> that represents the internal data model.
/// </typeparam>
/// <typeparam name="TExternal">
///     Type of the <see cref="IEntity"/> that represents the external data model.
/// </typeparam>
public abstract class BCommonEntity<TInternal, TExternal>
    : BEntity, ICommonEntity<TInternal, TExternal>
    where TInternal : ICommonScopeEntity
    where TExternal : ICommonScopeEntity {

    public TInternal? Internal { get; set; }

    public TExternal? External { get; set; }
}
