﻿using System.Net;

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.TrailerExternal>;


namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_TrailersExternalsController
    : BQ_CustomServerController {

    private class Frame : SuccessFrame<View> { }


    public Q_TrailersExternalsController(WebApplicationFactory<Program> hostFactory)
        : base("TrailersExternals", hostFactory) {
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