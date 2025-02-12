

using System.Net;

using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using TWS_Security.Sets.Contacts;

namespace TWS_Foundation.Quality.Suit.Controllers.Security;
public class Q_ContactsController
    : BQ_CustomServerController<Contact> {

    public Q_ContactsController(WebApplicationFactory<Program> hostFactory)
        : base("Contacts", hostFactory) {

    }

    protected override Contact MockFactory(string RandomSeed) {
        return new Contact {
            Name = RandomSeed,
            Lastname = RandomSeed,
            Email = RandomSeed,
            Phone = RandomSeed[..10],
        };
    }

    [Fact]
    public async Task Create() {
        {
            Contact[] mocks = MockFactory(5);

            (HttpStatusCode Status, GenericFrame Frame) = await Post("Create", mocks, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            SetBatchOut<Contact> creationResult = Framing<SuccessFrame<SetBatchOut<Contact>>>(Frame).Estela;

            Assert.Multiple([
                () => Assert.Equal(mocks.Length, creationResult.QTransactions),
                () => Assert.Equal(mocks.Length, creationResult.QSuccesses),
                () => Assert.All(creationResult.Successes, (i) => {
                    Assert.True(i.Id > 0);
                }),
            ]);
        }
    }
}
