using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Quality.Tools;

using TWS_Customer.Services;

namespace TWS_Customer.Quality.Suits.Services;

/// <summary>
///     Base Quality Implementation for a Service Quality Suit.
/// </summary>
/// <typeparam name="TSet">
///     Set service is based on.
/// </typeparam>
/// <typeparam name="TService">
///     Service type implementation based on.
/// </typeparam>
/// <typeparam name="TDatabase">
///     Database that holds the <see cref="ISet"/> related to the <see cref="TService"/>.
/// </typeparam>
public abstract class BQ_Service<TSet, TService, TDatabase>
    : IDisposable
    where TSet : class, ISet
    where TService : IService<TSet>
    where TDatabase : BDatabase_SQLServer<TDatabase>, new() {

    /// <summary>
    ///     Quality suit implementation service.
    /// </summary>
    protected readonly TService Service;

    /// <summary>
    ///     Record disposer for test data.
    /// </summary>
    protected readonly QDisposer Disposer;

    /// <summary>
    ///     Database that holds the <see cref="ISet"/> this implementation is based on. Usually to handle test data creation and direct disposition.
    /// </summary>
    protected readonly TDatabase Database = new();

    /// <summary>
    ///     Creates a new base quality implementation for a Service Quality Suit.
    /// </summary>
    /// <param name="Service">
    ///     Service based implementation.
    /// </param>
    public BQ_Service(TService Service) {
        this.Service = Service;

        Disposer = new QDisposer {
            Factory = () => Database,
        };
    }
    public void Dispose() {
        Disposer.Dispose();
        GC.SuppressFinalize(this);
    }

    /// <summary>
    ///     Proxy to determine the way to generate samplers, handled from the implementation itself.
    /// </summary>
    /// <param name="Entropy">
    ///     Rangom generated entropy value (16 digits) to use for unique properties.
    /// </param>
    /// </param>
    /// <returns> 
    ///     A <see cref="TSet"/> object to store and use as test data.
    /// </returns>
    protected abstract TSet ComposeSample(string Entropy);

    /// <summary>
    ///     Compose a bundle of Samples. 
    /// </summary>
    /// <param name="Quantity">
    ///     The number of samples composed.
    /// </param>
    /// <param name="Store">
    ///     Wheter the Samples must be stored directly in the data storage.
    /// </param>
    /// <returns>
    ///     The collection of samples.
    /// </returns>
    protected TSet[] ComposeSamples(int Quantity, bool Store = false) {

        TSet[] samples = [];
        for (int i = 0; i < Quantity; i++) {
            samples = [.. samples, ComposeSample(RandomUtils.String(16))];
        }

        if (Store) {
            Database.Set<TSet>().AddRange(samples);
            Database.SaveChanges();
            Disposer.Push([..samples.Cast<ISet>()]);
        }
        return samples;
    }
}
