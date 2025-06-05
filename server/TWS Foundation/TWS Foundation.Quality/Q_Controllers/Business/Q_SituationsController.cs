using System.Net;

using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Server.Scheming;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Entities;

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
        (HttpStatusCode Status, ResponseSchema Response) = await Post("View", new ViewInput<Account> {
            Page = 1,
            Range = 10,
            Retroactive = false,
        }, true);

        Assert.Equal(HttpStatusCode.OK, Status);

        ViewOutput<Account> Estela = Framing<SuccessFrame<ViewOutput<Account>>>(Response).Content;
        Assert.True(Estela.Entities.Length > 0);
        Assert.Equal(1, Estela.Page);
        Assert.True(Estela.Pages > 0);
    }

}