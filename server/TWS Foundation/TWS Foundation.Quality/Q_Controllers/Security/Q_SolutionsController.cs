using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc.Testing;

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
