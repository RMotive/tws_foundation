using System.Net;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Sets;

using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.Section>;


namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_SectionsController
    : BQ_CustomServerController<Section> {

    private class Frame : SuccessFrame<View> { }


    public Q_SectionsController(WebApplicationFactory<Program> hostFactory)
        : base("Sections", hostFactory) {
    }

    protected override Section MockFactory(string RandomSeed) {
        int random = new Random().Next();
        decimal cords = (random % 100) + 0.1m;
        return new() {
            Status = 1,
            Name = "name" + RandomSeed,
            Yard = 0,
            Capacity = new Random().Next(100),
            Ocupancy = new Random().Next(100),
            LocationNavigation = new() {
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
            },
        };
    }

    protected override async Task<string> Authentication() {
        (HttpStatusCode Status, SuccessFrame<Session> Response) = await XPost<SuccessFrame<Session>, Credentials>("Security/Authenticate", new Credentials {
            Identity = Account.Identity,
            Password = Account.Password,
            Sign = "TWSMA"
        });

        return Status != HttpStatusCode.OK ? throw new ArgumentNullException(nameof(Status)) : Response.Estela.Token.ToString();
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
        List<Section> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(MockFactory(iterationTag));
        }

        (HttpStatusCode Status, GenericFrame response) = await Post("Create", mockList, true);
        SetBatchOut<Section> estela = Framing<SuccessFrame<SetBatchOut<Section>>>(response).Estela;
        Assert.Equal(HttpStatusCode.OK, Status);
        Assert.Empty(estela.Failures);
    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            Section mock = MockFactory(testTag);
            (HttpStatusCode Status, GenericFrame Respone) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            RecordUpdateOut<Section> creationResult = Framing<SuccessFrame<RecordUpdateOut<Section>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            Section updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            #region generate a new record
            string testTag = Guid.NewGuid().ToString()[..3];
            Section mock = MockFactory(testTag);

            (HttpStatusCode Status, GenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<Section> creationResult = Framing<SuccessFrame<RecordUpdateOut<Section>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            Section creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.Name, creationRecord.Name),
                () => Assert.Equal(mock.LocationNavigation!.Name, creationRecord.LocationNavigation!.Name),
            ]);
            #endregion

            #region update only main properties
            //Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            mock = creationRecord;

            mock.Name = updatedTag + RandomUtils.String(7);
            mock.LocationNavigation!.Name = updatedTag + RandomUtils.String(7);
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<Section> updateResult = Framing<SuccessFrame<RecordUpdateOut<Section>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            Section updateRecord = updateResult.Updated;
            Section previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.Status, updateRecord.Status),
                () => Assert.NotEqual(previousRecord.Name, updateRecord.Name),
                () => Assert.NotEqual(previousRecord.LocationNavigation!.Name, updateRecord.LocationNavigation!.Name),
            ]);
            #endregion
        }
        #endregion
    }


}