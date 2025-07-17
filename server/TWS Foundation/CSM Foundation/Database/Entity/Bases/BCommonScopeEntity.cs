namespace CSM_Foundation.Database.Entity.Bases;

/// <summary>
///     Represents a <see cref="ICommonEntity"/> scope referring it as a possible <see cref="ICommonEntity{TInternal, TExternal}.Internal"/>
///     or <see cref="ICommonEntity{TInternal, TExternal}.External"/> data.
/// </summary>
public interface ICommonScopeEntity
    : IEntity {
}

/// <summary>
///     Represents a <see cref="ICommonEntity"/> scope referring it as a possible <see cref="ICommonEntity{TInternal, TExternal}.Internal"/>
///     or <see cref="ICommonEntity{TInternal, TExternal}.External"/> data.
/// </summary>
/// <typeparam name="TCommonEntity">
///     Type of the <see cref="ICommonEntity"/> implementation that holds this <see cref="ICommonScopeEntity{TCommonEntity}"/> implementation.
/// </typeparam>
public interface ICommonScopeEntity<TCommonEntity>
    : ICommonScopeEntity
    where TCommonEntity : ICommonEntity {

    /// <summary>
    ///     <typeparamref name="TCommonEntity"/> data.
    /// </summary>
    public TCommonEntity Common { get; set; }
}

/// <summary>
///     Represents a <see cref="ICommonEntity"/> scope referring it as a possible <see cref="ICommonEntity{TInternal, TExternal}.Internal"/>
///     or <see cref="ICommonEntity{TInternal, TExternal}.External"/> data.
///     
///     <para>
///         This abstrac base provides { CMS } native built-in implementations to handle at low level
///         <see cref="ICommonScopeEntity"/> implementations.
///     </para>
/// </summary>
/// <typeparam name="TCommonEntity">
///     Type of the <see cref="ICommonEntity"/> implementation that holds this <see cref="ICommonScopeEntity{TCommonEntity}"/> implementation.
/// </typeparam>
public abstract class BCommonScopeEntity<TCommonEntity>
    : BEntity, ICommonScopeEntity<TCommonEntity>
    where TCommonEntity : ICommonEntity {

    public TCommonEntity Common { get; set; } = default!;
}
