using System.Net;

using CSM_Foundation.Database.Entity.Depot.IDepot_View;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Entities;

using TWS_Foundation.Middlewares.Frames;

namespace TWS_Foundation.Quality.Q_Controllers.Business;

public class Q_SitutationsController
    : BQ_FoundationServerController<Situation> {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="service"></param>
    /// <param name="hostFactory"></param>
    public Q_SitutationsController(string service, WebApplicationFactory<Program> hostFactory)
        : base(service, hostFactory) {
    }

    protected override Situation EntityFactory(string RandomSeed) {
        return new Situation() {
            Name = RandomSeed,
            Description = RandomSeed,
        };
    }

    [Fact]
    public async Task View() {
        (HttpStatusCode Status, GenericFrame Response) = await Post("View", new ViewInput<TWS_Security.Sets.Account> {
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