using CSM_Foundation.Core.Extensions;
using CSM_Foundation.Core.Utils;
using CSM_Foundation.Server.Records;
using System.Net;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Middlewares.Frames;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;

namespace TWS_Foundation.Quality.Q_Controllers.Security;

/// <summary>
/// 
/// </summary>
public class Q_SolutionsController
    : BQ_FoundationServerController<Solution> {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="service"></param>
    /// <param name="hostFactory"></param>
    public Q_SolutionsController(string service, WebApplicationFactory<Program> hostFactory) 
        : base(service, hostFactory) {
    }

    protected override Solution EntityFactory(string RandomSeed) {
        return new Solution() {
            Name = RandomSeed,
            Description = RandomSeed,
            Sign = RandomSeed[..5],
        };
    }
}
