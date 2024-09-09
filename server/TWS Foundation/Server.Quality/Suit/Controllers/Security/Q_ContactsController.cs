

using System.Net;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Quality.Bases;

using TWS_Security.Sets;

namespace TWS_Foundation.Quality.Suit.Controllers.Security;
public class Q_ContactsController
    : BQ_CustomServerController<Contact> {

    public Q_ContactsController(WebApplicationFactory<Program> hostFactory)
        : base("Contacts", hostFactory) {

    }

    protected override Contact MockFactory(string RandomSeed) {
        throw new NotImplementedException();
    }

    [Fact]
    public async Task Create() {
        {
            Contact[] mocks = [];
            for (int i = 0; i < 3; i++) {
                string uniqueToken = Guid.NewGuid().ToString();

                mocks = [
                    ..mocks,
                    new Contact {
                        Name = $"{i}_{uniqueToken[..20]}",
                        Lastname = $"{i}_{uniqueToken[..20]}",
                        Email = $"{i}_{uniqueToken[..20]}",
                        Phone = $"{i}_{uniqueToken[..14]}"
                    },
                ];
            }

            (HttpStatusCode Status, _) = await Post("Create", mocks, true);

            Assert.Equal(HttpStatusCode.OK, Status);
        }
    }
}
