﻿
using System.Net;

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Server.Quality.Bases;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.TruckExternal>;


namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_TrucksExternalsController 
    : BQ_CustomServerController {

    private class Frame : SuccessFrame<View> { }


    public Q_TrucksExternalsController(WebApplicationFactory<Program> hostFactory)
        : base("TrucksExternals", hostFactory) {
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
}