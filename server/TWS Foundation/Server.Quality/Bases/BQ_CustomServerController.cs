using System.Net;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Server.Quality.Bases;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Records;

using TWS_Foundation.Quality.Secrets;

using PrivilegesFrame = TWS_Foundation.Middlewares.Frames.SuccessFrame<TWS_Customer.Managers.Records.Session>;

namespace TWS_Foundation.Quality.Bases;
public abstract class BQ_CustomServerController
    : BQ_ServerController<Program> {

    protected BQ_CustomServerController(string Service, WebApplicationFactory<Program> hostFactory)
        : base(Service, hostFactory) {
    }

    protected override async Task<string> Authentication() {
        (HttpStatusCode Status, GenericFrame Frame) = await XPost<GenericFrame, Credentials>("Security/Authenticate", new Credentials {
            Identity = Account.Identity,
            Password = Account.Password,
            Sign = "TWSMA",
        });
        Dictionary<string, object> estela = Frame.Estela;
        if (Status != HttpStatusCode.OK) {
            Assert.Fail($"Failed request with: {estela[nameof(ServerExceptionPublish.System)]} \ndue to: {estela[nameof(ServerExceptionPublish.Advise)]} \nTried with: {Account.Identity}");
        }
        PrivilegesFrame successFrame = Framing<PrivilegesFrame>(Frame);
        Session session = successFrame.Estela;
        Assert.True(session.Wildcard, $"User {session.Identity} doesn't have wildcard enabled");
        Assert.Equal(Account.Identity, session.Identity);

        if (!session.Permits.Any(i => i.Reference == "AAA000001")) {
            Assert.Fail($"Account ({Account.Identity}) doesn't contain (Quality[AAA000001]) permit");
        }

        return session.Token.ToString();
    }
}

public abstract class BQ_CustomServerController<TSet>
    : BQ_CustomServerController
    where TSet : ISet {
    protected BQ_CustomServerController(string Service, WebApplicationFactory<Program> hostFactory)
        : base(Service, hostFactory) {
    }

    protected abstract TSet MockFactory(string RandomSeed);

    protected TSet[] MockFactory(int Quantity) {
        TSet[] mocks = [];
        for (int i = 0; i < Quantity; i++) {
            mocks = [.. mocks, MockFactory(RandomUtils.String(16))];
        }

        return mocks;
    }
}
