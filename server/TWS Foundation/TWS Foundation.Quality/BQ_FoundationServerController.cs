using System.Collections.Generic;
using System.Net;
using System.Text;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Server.Quality.Bases;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;

namespace TWS_Foundation.Quality;

/// <summary>
/// 
/// </summary>
public abstract class BQ_FoundationServerController
    : BQ_ServerController<Program> {

    /// <summary>
    ///     
    /// </summary>
    readonly AuthenticationInput _qualityAuth;

    public BQ_FoundationServerController(string service, WebApplicationFactory<Program> hostFactory)
        : base(service, "TWSMF", hostFactory) {

        string? qualityIdentity = Environment.GetEnvironmentVariable("Q.Identity");
        string? qualityPassword = Environment.GetEnvironmentVariable("Q.Password");

        if (qualityIdentity == null || qualityPassword == null) {
            throw new Exception($"Unconfigured quality purpose authentication information at runsettings, <Q.Identity> and <Q.Password>");
        }

        _qualityAuth = new AuthenticationInput {
            Sign = "TWSMF",
            Identity = qualityIdentity,
            Password = Encoding.UTF8.GetBytes(qualityPassword)
        };
    }

    protected override async Task<string> Authenticate() {
        (HttpStatusCode statusCode, GenericFrame frameResult) = await XPost<GenericFrame, AuthenticationInput>("Security/Authenticate", _qualityAuth);

        Dictionary<string, object> estela = frameResult.Estela;
        if (statusCode != HttpStatusCode.OK) {
            Assert.Fail($"Failed request with: {estela[nameof(ExceptionInfo.System)]} \ndue to: {estela[nameof(ExceptionInfo.Advise)]} \nTried with: {_qualityAuth.Identity}");
        }
        SuccessFrame<ServerSession> successFrame = Framing<SuccessFrame<ServerSession>>(frameResult);
        ServerSession session = successFrame.Estela;

        Assert.True(session.Wildcard, $"User {session.Identity} doesn't have wildcard enabled");
        Assert.Equal(_qualityAuth.Identity, session.Identity);

        if (!session.Permits.Any(i => i.Reference == "TWSMFD01")) {
            Assert.Fail($"Account ({_qualityAuth.Identity}) doesn't contain (Development[TWSMFD01]) permit");
        }

        return session.Token.ToString();
    }
}


/// <summary>
/// 
/// </summary>
/// <typeparam name="T"></typeparam>
public abstract class BQ_FoundationServerController<T>
    : BQ_FoundationServerController 
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
