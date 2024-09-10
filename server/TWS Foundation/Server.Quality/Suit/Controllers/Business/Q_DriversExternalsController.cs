
using System.Net;

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Sets;

using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.DriverExternal>;


namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_DriversExternalsController : BQ_CustomServerController<DriverExternal> {
    private class Frame : SuccessFrame<View> { }


    public Q_DriversExternalsController(WebApplicationFactory<Program> hostFactory)
        : base("DriversExternals", hostFactory) {
    }

    protected override DriverExternal MockFactory(string RandomSeed) {
        throw new NotImplementedException();
    }

    protected override async Task<string> Authentication() {
        (HttpStatusCode Status, SuccessFrame<Session> Response) = await XPost<SuccessFrame<Session>, Credentials>("Security/Authenticate", new Credentials {
            Identity = Account.Identity,
            Password = Account.Password,
            Sign = "TWSMA"
        });

        return Status != HttpStatusCode.OK ? throw new ArgumentNullException(nameof(Status)) : Response.Estela.Token.ToString();
    }

    [Fact]
    public async Task View() {
        (HttpStatusCode Status, GenericFrame Response) = await Post("View", new SetViewOptions<TWS_Security.Sets.Account> {
            Page = 1,
            Range = 10,
            Retroactive = false,
        }, true);

        Assert.Equal(HttpStatusCode.OK, Status);

        View Estela = Framing<SuccessFrame<View>>(Response).Estela;
        Assert.True(Estela.Sets.Length > 0);
        Assert.Equal(1, Estela.Page);
        Assert.True(Estela.Pages > 0);
    }
}