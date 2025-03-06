using System.Net;

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Server.Records;

using CSM_Security.Entities.Accounts;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Entities.Carriers.Carrier>;

namespace TWS_Foundation.Quality.Suit.Controllers.Business;

public class Q_CarriersController
    : BQ_CustomServerController {

    private class Frame : SuccessFrame<View> { }

    public Q_CarriersController(WebApplicationFactory<Program> hostFactory)
        : base("Carriers", hostFactory) {
    }
    protected override async Task<string> Authentication() {
        (HttpStatusCode Status, SuccessFrame<Session> Response) = await XPost<SuccessFrame<Session>, Credentials>("Security/Authenticate", new Credentials {
            Identity = Secrets.Account.Identity,
            Password = Secrets.Account.Password,
            Sign = "TWSMA"
        });

        return Status != HttpStatusCode.OK ? throw new ArgumentNullException(nameof(Status)) : Response.Estela.Token.ToString();
    }
    [Fact]
    public async Task View() {
        (HttpStatusCode Status, GenericFrame Response) = await Post("View", new SetViewOptions<Account> {
            Page = 1,
            Range = 10,
            Retroactive = false,
        }, true);

        Assert.Equal(HttpStatusCode.OK, Status);

        View Estela = Framing<SuccessFrame<View>>(Response).Estela;
        Assert.True(Estela.Records.Length > 0);
        Assert.Equal(1, Estela.Page);
        Assert.True(Estela.Pages > 0);
    }

}
