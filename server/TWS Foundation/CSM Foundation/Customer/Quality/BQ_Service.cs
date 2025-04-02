using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Quality.Disposing;

namespace CSM_Foundation.Customer.Quality;


public delegate TService ServiceFactory<TService>();

/// <summary>
///     [Abstract] class for quality purposes, handling properties and utilities for [Service] test operations.
/// </summary>
/// <typeparam name="TService">
///     Type of the [Service] interface representation.
/// </typeparam>
public abstract class BQ_Service<TService> 
    : BQ_DataHandler {

    /// <summary>
    ///     Service instance to qualify operations.
    /// </summary>
    protected readonly TService _service;
    
    /// <summary>
    ///     Creates a new <see cref="BQ_Service{TService}"/> instance.
    /// </summary>
    /// <param name="serviceFactory">
    ///     The main feature service factory to quality purposes.
    /// </param>
    /// <param name="databaseFactories">
    ///     Databases factories from all the created entities can became. (this is mainly used for multi-databases solutions where some entities are related to another ones but came from different databases instances)
    /// </param>
    public BQ_Service(params DatabaseFactory[] databaseFactories) 
        : base(databaseFactories) { 

        _service = ServiceFactory();
    }


    protected abstract TService ServiceFactory();
}
