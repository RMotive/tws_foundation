using System.Net;

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using Account = TWS_Security.Sets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Security.Sets.Account>;

namespace TWS_Foundation.Quality.Suit.Controllers.Security;


public class Q_AccountsService
    : BQ_CustomServerController<Account> {

    public Q_AccountsService(WebApplicationFactory<Program> hostFactory)
        : base("Accounts", hostFactory) {
    }

    protected override Account MockFactory(string RandomSeed) {
        throw new NotImplementedException();
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
        Assert.True(Estela.Records.Length > 0);
        Assert.Equal(1, Estela.Page);
        Assert.True(Estela.Pages > 0);
    }
}