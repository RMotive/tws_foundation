using System.Net;

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Entities.Vehicules.VehiculeModel>;

namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_VehiculesModelsController
    : BQ_CustomServerController {

    public Q_VehiculesModelsController(WebApplicationFactory<Program> hostFactory)
        : base("VehiculesModels", hostFactory) {
    }

    [Fact]
    public async Task View() {
        (HttpStatusCode Status, GenericFrame Response) = await Post("View", new SetViewOptions<CSM_Security.Entities.Accounts.Account> {
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
