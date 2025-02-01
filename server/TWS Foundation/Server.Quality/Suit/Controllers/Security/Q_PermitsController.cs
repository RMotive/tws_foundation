using System.Net;

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using TWS_Security.Sets;

using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Security.Sets.Permit>;

namespace TWS_Foundation.Quality.Suit.Controllers.Security;


public class Q_PermitsController
    : BQ_CustomServerController<Permit> {

    public Q_PermitsController(WebApplicationFactory<Program> hostFactory)
        : base("Permits", hostFactory) {
    }

    protected override Permit MockFactory(string RandomSeed) {
        throw new NotImplementedException();
    }

    [Fact]
    public async Task View() {
        (HttpStatusCode Status, GenericFrame Response) = await Post("View", new SetViewOptions<Permit> {
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