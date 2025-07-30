using CSM_Foundation.Database;
using CSM_Foundation.Database.Utilitites;
using CSM_Foundation.Product;

namespace TWS_Customer.Quality;

/// <summary>
/// 
/// </summary>
/// <typeparam name="TService"></typeparam>
public abstract class BQ_Service<TService>
    : CSM_Foundation.Product.BQ_Service<TService>
    where TService : IService {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    public BQ_Service()
        : base(
                [
                    BuildBusinessDb,
                    BuildSecurityDb,
                ]
            ) {
    }

    /// <summary>
    ///     Creates a new <see cref="CSM_Security.Database"/> instance.
    /// </summary>
    /// <returns>
    ///     A new <see cref="CSM_Security.Database"/> instance.
    /// </returns>
    protected static CSM_Security.Database BuildSecurityDb()
    => DatabaseUtilities.Q_Construct<CSM_Security.Database>(CSM_Security.Database.SIGN);

    /// <summary>
    ///     Creates a new <see cref="TWS_Business.Database"/> instance.
    /// </summary>
    /// <returns>
    ///     A new <see cref="TWS_Business.Database"/> instance.
    /// </returns>
    protected static TWS_Business.Database BuildBusinessDb()
    => DatabaseUtilities.Q_Construct<TWS_Business.Database>(TWS_Business.Database.SIGN);
}

/// <summary>
///     Represents a quality testing class for a { CSM CargoFleet } product service.
/// </summary>
/// <typeparam name="TService">
///     Type of the service to be tested.
/// </typeparam>
/// <typeparam name="TEntity">
///     Type of the entity the service to be tested is based on.
/// </typeparam>
public abstract class BQ_Service<TService, TEntity>
    : CSM_Foundation.Product.BQ_Service<TService, TEntity>
    where TService : IService<TEntity>
    where TEntity : class, IEntity {


    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    public BQ_Service()
        : base(
                [
                    BuildBusinessDb,
                    BuildSecurityDb,
                ]
            ) {
    }

    /// <summary>
    ///     Creates a new <see cref="CSM_Security.Database"/> instance.
    /// </summary>
    /// <returns>
    ///     A new <see cref="CSM_Security.Database"/> instance.
    /// </returns>
    protected static CSM_Security.Database BuildSecurityDb()
    => DatabaseUtilities.Q_Construct<CSM_Security.Database>(CSM_Security.Database.SIGN);

    /// <summary>
    ///     Creates a new <see cref="TWS_Business.Database"/> instance.
    /// </summary>
    /// <returns>
    ///     A new <see cref="TWS_Business.Database"/> instance.
    /// </returns>
    protected static TWS_Business.Database BuildBusinessDb()
    => DatabaseUtilities.Q_Construct<TWS_Business.Database>(TWS_Business.Database.SIGN);
}
