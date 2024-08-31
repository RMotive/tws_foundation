using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Quality.Bases;

using Xunit;

namespace TWS_Foundation.Quality.Suit.Controllers;

public class Q_SecurityController
    : BQ_CustomServerController {
    public Q_SecurityController(WebApplicationFactory<Program> hostFactory)
        : base("Security", hostFactory) { }

    [Fact]
    public async Task Authenticate() {
        _ = await Authentication();
    }
}
