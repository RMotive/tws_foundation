using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Quality.Bases;

namespace TWS_Foundation.Quality.Suit.Controllers.Security;

public class Q_SecurityController
    : BQ_CustomServerController {
    public Q_SecurityController(WebApplicationFactory<Program> hostFactory)
        : base("Security", hostFactory) { }

    [Fact]
    public async Task Authenticate() {
        await Authentication();
    }
}
