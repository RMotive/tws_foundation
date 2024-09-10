﻿


using System.Net;

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Server.Quality.Bases;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Sets;

using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.Manufacturer>;

namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_ManufacturerController
    : BQ_ServerController<Program> {

    private class Frame : SuccessFrame<View> { }

    public Q_ManufacturerController(WebApplicationFactory<Program> hostFactory)
        : base("Manufacturers", hostFactory) {
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
        DateOnly date = new(2024, 10, 10);

        Manufacturer mock = new() {
            Model = "X23",
            Brand = "SCANIA ctr T1",
            Year = date
        };

        (HttpStatusCode Status, GenericFrame Response) = await Post("Create", mock, true);

        _ = Response.Estela.TryGetValue("Advise", out object? value);
        Assert.Null(value);
        Assert.Equal(HttpStatusCode.OK, Status);
    }

}
