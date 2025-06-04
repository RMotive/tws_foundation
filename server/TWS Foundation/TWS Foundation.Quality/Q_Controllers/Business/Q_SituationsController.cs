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



}