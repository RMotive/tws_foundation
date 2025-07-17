using System.Net;

using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Server.Scheming;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Entities.Drivers;

using TWS_Foundation.Middlewares.Frames;

namespace TWS_Foundation.Quality.Q_Controllers.Business;
public class Q_DriversController
    : BQ_FoundationServerController<Driver_Common> {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="service"></param>
    /// <param name="hostFactory"></param>
    public Q_DriversController(WebApplicationFactory<Program> hostFactory)
        : base("/Drivers", hostFactory) {
    }

    protected override Driver_Common EntityFactory(string RandomSeed) {
        return new Driver_Common() { };
    }

    [Fact]
    public async Task View() {
        (HttpStatusCode Status, ResponseSchema Response) = await Post("View", new ViewInput<Driver_Common> {
            Page = 1,
            Range = 10,
            Retroactive = false,
        }, true);

        Assert.Equal(HttpStatusCode.OK, Status);

        ViewOutput<Driver_Common> Estela = Framing<SuccessFrame<ViewOutput<Driver_Common>>>(Response).Content;
        Assert.True(Estela.Entities.Length > 0);
        Assert.Equal(1, Estela.Page);
        Assert.True(Estela.Pages > 0);
    }
}
