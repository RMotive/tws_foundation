using System.Net;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Sets;

using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.Plate>;


namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_PlatesController
    : BQ_CustomServerController {
    private class Frame : SuccessFrame<View> { }


    public Q_PlatesController(WebApplicationFactory<Program> hostFactory)
        : base("Plates", hostFactory) {
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

    [Fact]
    public async Task Create() {
        DateOnly date = DateOnly.FromDateTime(DateTime.Now);

        (HttpStatusCode Status, GenericFrame Response) = await Post("Create", new Plate() {
            Identifier = RandomUtils.String(10),
            Status = 1,
            State = "ABC",
            Country = "MXN",
            Expiration = date,
            Truck = 0,
            TruckNavigation = new() {
                Id = 0,
                Status = 1,
                Common = 0,
                Vin = RandomUtils.String(17),
                Carrier = 0,
                Model = 0,
                TruckCommonNavigation = new() {
                    Status = 1,
                    Economic = RandomUtils.String(16)
                },
                VehiculeModelNavigation = new() {
                    Status = 1,
                    Name = RandomUtils.String(32),
                    Year = date,
                    Manufacturer = 0,
                    ManufacturerNavigation = new() {
                        Name = RandomUtils.String(32),
                    }
                },
                CarrierNavigation = new() {
                    Status = 1,
                    Name = RandomUtils.String(10),
                    Approach = 0,
                    Address = 0,
                    ApproachNavigation = new() {
                        Status = 1,
                        Email = RandomUtils.String(30)
                    },
                    AddressNavigation = new() {
                        Country = "USA"
                    }
                }
            }
        }, true);

        Response.Estela.TryGetValue("Advise", out object? value);
        Assert.Null(value);
        Assert.Equal(HttpStatusCode.OK, Status);

    }
}