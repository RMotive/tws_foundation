using System.Net;

using CSM_Foundation.Server.Records;
using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Security.Sets.Account>;

namespace TWS_Foundation.Quality.Suit.Controllers;


public class Q_AccountsService
    : BQ_CustomServerController {

    public Q_AccountsService(WebApplicationFactory<Program> hostFactory)
        : base("Accounts", hostFactory) {
    }

    [Fact]
    public async Task View() {
        (HttpStatusCode Status, ServerGenericFrame Response) = await Post("View", new SetViewOptions {
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