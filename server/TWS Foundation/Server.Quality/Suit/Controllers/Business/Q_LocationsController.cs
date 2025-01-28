
using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Server.Records;
using Microsoft.AspNetCore.Mvc.Testing;

using System;
using System.Net;

using TWS_Business.Sets;

using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.Location>;

namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_LocationsController
    : BQ_CustomServerController<Location> {
    public Q_LocationsController(WebApplicationFactory<Program> hostFactory)
        : base("Locations", hostFactory) {
    }
    protected override async Task<string> Authentication() {
        (HttpStatusCode Status, SuccessFrame<Session> Response) = await XPost<SuccessFrame<Session>, Credentials>("Security/Authenticate", new Credentials {
            Identity = Account.Identity,
            Password = Account.Password,
            Sign = "TWSMA"
        });

        return Status != HttpStatusCode.OK ? throw new ArgumentNullException(nameof(Status)) : Response.Estela.Token.ToString();
    }

    protected override Location MockFactory(string RandomSeed) {
        int random = new Random().Next();
        decimal cords = (random % 100) + 0.1m;
        return new() {
            Status = 1,
            Name = "name " + RandomSeed,
            AddressNavigation = new() {
                Country = "USA",
                City = "city " + RandomSeed,
            },
            WaypointNavigation = new() {
                Status = 1,
                Longitude = cords,
                Latitude = cords,
                Altitude = cords,
            }
        };
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
        List<Location> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(MockFactory(iterationTag));
        }

        (HttpStatusCode Status, GenericFrame response) = await Post("Create", mockList, true);
        SetBatchOut<Location> estela = Framing<SuccessFrame<SetBatchOut<Location>>>(response).Estela;
        Assert.Equal(HttpStatusCode.OK, Status);
        Assert.Empty(estela.Failures);
    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            Location mock = MockFactory(testTag);
            (HttpStatusCode Status, GenericFrame Respone) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            RecordUpdateOut<Location> creationResult = Framing<SuccessFrame<RecordUpdateOut<Location>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            Location updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            #region generate a new record
            string testTag = Guid.NewGuid().ToString()[..3];
            Location mock = MockFactory(testTag);

            (HttpStatusCode Status, GenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<Location> creationResult = Framing<SuccessFrame<RecordUpdateOut<Location>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            Location creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.AddressNavigation!.City, creationRecord.AddressNavigation!.City),
                () => Assert.Equal(mock.WaypointNavigation!.Longitude, creationRecord.WaypointNavigation!.Longitude),
            ]);
            #endregion

            #region update only main properties
            //Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            mock = creationRecord;

            mock.AddressNavigation!.City = updatedTag + RandomUtils.String(7);
            mock.WaypointNavigation!.Latitude = 99.99m;
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<Location> updateResult = Framing<SuccessFrame<RecordUpdateOut<Location>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            Location updateRecord = updateResult.Updated;
            Location previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.AddressNavigation!.Country, updateRecord.AddressNavigation!.Country),
                () => Assert.NotEqual(previousRecord.AddressNavigation!.City, updateRecord.AddressNavigation!.City),
                () => Assert.NotEqual(previousRecord.WaypointNavigation!.Latitude, updateRecord.WaypointNavigation!.Latitude),
            ]);
            #endregion
        }
        #endregion
    }
}



