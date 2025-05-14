using System.Net;
using System.Text;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Server;
using CSM_Foundation.Server.Quality;
using CSM_Foundation.Server.Scheming;

using Microsoft.AspNetCore.Mvc.Testing;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;

namespace TWS_Foundation.Quality;

/// <summary>
///     <see langword="abstract"/> class from <see cref="BQ_Controller{T}"/>.
///     
///     <para> 
///         Defines a custom <see cref="TWS_Foundation"/> server scope base behavior for a controller quality/testing purposes
///     </para>
/// </summary>
public abstract class BQ_FoundationController
    : BQ_Controller<Program> {

    /// <summary>
    ///     Authentication information for quality/testing requests that requires it.
    /// </summary>
    readonly AuthenticationInput _auth;

    /// <summary>
    ///     Creates a new <see cref="BQ_FoundationController"/> instance.
    /// </summary>
    /// <param name="controllerPath">
    ///     Relative controller path.
    /// </param>
    /// <param name="hostFactory">
    ///     Dependency injected after <see cref="IClassFixture{TFixture}"/> is resolved for server simulation.
    /// </param>
    /// <exception cref="Exception">
    ///     Thrown when the tests environment variables can't find quality authentication information.
    /// </exception>
    public BQ_FoundationController(string controllerPath, WebApplicationFactory<Program> hostFactory)
        : base(controllerPath, "TWSMF", hostFactory) {

        string? qIdentity = Environment.GetEnvironmentVariable("Q.Identity");
        string? qPassword = Environment.GetEnvironmentVariable("Q.Password");

        if (qIdentity == null || qPassword == null) {
            throw new Exception($"Unconfigured quality purpose authentication information at runsettings, <Q.Identity> and <Q.Password>");
        }

        _auth = new AuthenticationInput {
            Sign = "TWSMF",
            Identity = qIdentity,
            Password = Encoding.UTF8.GetBytes(qPassword)
        };
    }

    protected override async Task<string> Authenticate() {
        Q_ServerClient_Response<> = await XPost<ResponseSchema, AuthenticationInput>("Security/Authenticate", _auth);

        Dictionary<string, object> estela = frameResult.Content;
        if (statusCode != HttpStatusCode.OK) {
            Assert.Fail($"Failed request with: {estela[nameof(ExceptionInfo.System)]} \ndue to: {estela[nameof(ExceptionInfo.Advise)]} \nTried with: {_auth.Identity}");
        }
        SuccessFrame<ServerSession> successFrame = Framing<SuccessFrame<ServerSession>>(frameResult);
        ServerSession session = successFrame.Content;

        Assert.True(session.Wildcard, $"User {session.Identity} doesn't have wildcard enabled");
        Assert.Equal(_auth.Identity, session.Identity);

        if (!session.Permits.Any(i => i.Reference == "TWSMFD01")) {
            Assert.Fail($"Account ({_auth.Identity}) doesn't contain (Development[TWSMFD01]) permit");
        }

        return session.Token.ToString();
    }
}


/// <summary>
/// 
/// </summary>
/// <typeparam name="T"></typeparam>
public abstract class BQ_FoundationServerController<T>
    : BQ_FoundationController
    where T : IEntity {


    protected BQ_FoundationServerController(string service, WebApplicationFactory<Program> hostFactory)
        : base(service, hostFactory) {
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="RandomSeed"></param>
    /// <returns></returns>
    protected abstract T EntityFactory(string RandomSeed);

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Quantity"></param>
    /// <returns></returns>
    protected T[] EntityFactory(int Quantity) {
        T[] mocks = [];
        for (int i = 0; i < Quantity; i++) {
            mocks = [.. mocks, EntityFactory(RandomUtils.String(16))];
        }

        return mocks;
    }
}
