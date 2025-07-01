using System.Net;
using System.Text;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Server;
using CSM_Foundation.Server.Quality;
using CSM_Foundation.Server.Scheming;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Customer.Services.Records;

namespace TWS_Foundation.Quality;

/// <summary>
/// 
/// </summary>
public abstract class BQ_FoundationServerController
    : BQ_Controller<Program>  {

    /// <summary>
    ///     
    /// </summary>
    readonly AuthInput _qualityAuth;

    public BQ_FoundationServerController(string service, WebApplicationFactory<Program> hostFactory)
        : base(service, "TWSMF", hostFactory) {

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
        (HttpStatusCode statusCode, ResponseSchema frameResult) = await XPost<ResponseSchema, AuthInput>("Security/Authenticate", _qualityAuth);



        return "";
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
