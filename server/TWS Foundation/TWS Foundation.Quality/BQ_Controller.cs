using System.Net;
using System.Text;

using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Server.Scheming;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Customer.Services.Records;

namespace TWS_Foundation.Quality;

/// <summary>
///     Represents a quality { CargoFleet } controller, used for testing purposes over server controllers.
/// </summary>
public abstract class BQ_Controller
    : CSM_Foundation.Server.Quality.BQ_Controller<Program> {

    /// <summary>
    ///     Authentication data used on secure endpoints.
    /// </summary>
    readonly AuthInput _qualityAuth;

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="controllerPath">
    ///     Controller path.
    /// </param>
    /// <param name="hostFactory">
    ///     Fixture proxy application factory dependency.
    /// </param>
    /// <exception cref="Exception"/>
    public BQ_Controller(string controllerPath, WebApplicationFactory<Program> hostFactory)
        : base(controllerPath, "TWSMF", hostFactory) {

        string? qualityIdentity = Environment.GetEnvironmentVariable("Q.Identity");
        string? qualityPassword = Environment.GetEnvironmentVariable("Q.Password");

        if (qualityIdentity == null || qualityPassword == null) {
            throw new Exception($"Unconfigured quality purpose authentication information at runsettings, <Q.Identity> and <Q.Password>");
        }

        _qualityAuth = new AuthInput {
            Sign = "TWSMF",
            Identity = qualityIdentity,
            Password = Encoding.UTF8.GetBytes(qualityPassword)
        };
    }

    protected override async Task<string> Authenticate() {
        (HttpStatusCode _, ResponseSchema __) = await XPost<ResponseSchema, AuthInput>("Security/Authenticate", _qualityAuth);
        return "";
    }
}


/// <summary>
///     Represents a quality { CargoFleet } controller, used for testing purposes over server controller.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> implementation the controller's service is based on.
/// </typeparam>
public abstract class BQ_Controller<TEntity>
    : BQ_Controller
    where TEntity : IEntity {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="controllerPath">
    ///     Controller path.
    /// </param>
    /// <param name="hostFactory">
    ///     Fixture proxy application factory dependency.
    /// </param>
    protected BQ_Controller(string controllerPath, WebApplicationFactory<Program> hostFactory)
        : base(controllerPath, hostFactory) {
    }

    /// <summary>
    ///     Creaes a new <typeparamref name="TEntity"/> sample instance, this means is not saved at live
    ///     data storages is just a sample data object with randomized values.
    /// </summary>
    /// <param name="entropyValue">
    ///     Randomized (16) length value.
    /// </param>
    /// <returns>
    ///     A sample <typeparamref name="TEntity"/> instance.
    /// </returns>
    protected abstract TEntity EntityFactory(string entropyValue);

    /// <summary>
    ///     Creaes a new <typeparamref name="TEntity"/> collection of sample instances, this means are not saved at live
    ///     data storages is just a collection of sample data objects with randomized values.
    /// </summary>
    /// <param name="quantity">
    ///     The quantity of <typeparamref name="TEntity"/> instances to create.
    /// </param>
    /// <returns>
    ///     A sample collection of <typeparamref name="TEntity"/> instances.
    /// </returns>
    protected TEntity[] EntityFactory(int quantity) {
        TEntity[] mocks = [];
        for (int i = 0; i < quantity; i++) {
            mocks = [.. mocks, EntityFactory(RandomUtils.String(16))];
        }

        return mocks;
    }
}

/// <summary>
///     Represents a quality { CargoFleet } controller, used for testing purposes over server controller.
/// </summary>
/// <typeparam name="TCommonEntity">
///     Type of the <see cref="ICommonEntity"/> implementation the controller's service is based on.
/// </typeparam>
public abstract class BQ_Controller_CommonEntity<TCommonEntity>
    : BQ_Controller
    where TCommonEntity : IPartnerBridgeEntity {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="controllerPath">
    ///     Controller path.
    /// </param>
    /// <param name="hostFactory">
    ///     Fixture proxy application factory dependency.
    /// </param>
    protected BQ_Controller_CommonEntity(string controllerPath, WebApplicationFactory<Program> hostFactory)
        : base(controllerPath, hostFactory) {
    }



}