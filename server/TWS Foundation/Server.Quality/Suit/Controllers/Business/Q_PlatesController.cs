using System.Net;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Entities.Vehicules.Plate>;


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

    [Fact]
    public async Task Create() {
        DateOnly date = DateOnly.FromDateTime(DateTime.Now);

        (HttpStatusCode Status, GenericFrame Response) = await Post("Create", new Plate() {
            Identifier = RandomUtils.String(10),
            Status = new Status { Id = 1 },
            State = "ABC",
            Country = "MXN",
            Expiration = date,
            Truck = new() {
                VIN = RandomUtils.String(17),
                Common = new() {
                    Status = new Status { Id = 1 },
                    Economic = RandomUtils.String(16)
                },
                Model = new() {
                    Status = new Status { Id = 1 },
                    Name = RandomUtils.String(32),
                    Year = date,
                    Manufacturer = new() {
                        Name = RandomUtils.String(32),
                    }
                },
                Carrier = new() {
                    Name = RandomUtils.String(10),
                    Status = new Status {
                        Id = 1,
                    },
                    Approach = new() {
                        Status = new Status { Id = 1 },
                        EMail = RandomUtils.String(30)
                    },
                    Address = new() {
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