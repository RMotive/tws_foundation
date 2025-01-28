using System.Net;

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Sets;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.Employee>;

namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_EmployeesController
    : BQ_CustomServerController<Employee> {

    public Q_EmployeesController(WebApplicationFactory<Program> hostFactory)
        : base("Employees", hostFactory) {
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

    protected override Employee MockFactory(string RandomSeed) {
        throw new NotImplementedException();
    }
}