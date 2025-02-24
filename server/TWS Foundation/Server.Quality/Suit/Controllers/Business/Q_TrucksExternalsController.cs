
using System.Net;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Sets;

using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.TruckExternal>;


namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_TrucksExternalsController
    : BQ_CustomServerController<TruckExternal> {

    public Q_TrucksExternalsController(WebApplicationFactory<Program> hostFactory)
        : base("TrucksExternals", hostFactory) {
    }

    protected override async Task<string> Authentication() {
        (HttpStatusCode Status, SuccessFrame<Session> Response) = await XPost<SuccessFrame<Session>, Credentials>("Security/Authenticate", new Credentials {
            Identity = Account.Identity,
            Password = Account.Password,
            Sign = "TWSMA"
        });

        return Status != HttpStatusCode.OK ? throw new ArgumentNullException(nameof(Status)) : Response.Estela.Token.ToString();
    }

    protected override TruckExternal MockFactory(string RandomSeed) {
        Address addressCommon = new() {
            Street = "Trucks Location " + RandomSeed,
            Country = "USA"
        };
        Situation situation = new() {
            Name = "Situational test " + RandomSeed,
            Description = "Description test " + RandomSeed
        };
        Location location = new() {
            Name = "random location: " + RandomSeed,
            Status = 1,
            Address = 0,
            AddressNavigation = addressCommon,
        };
        TruckCommon common = new() {
            Status = 1,
            Economic = "EconomicTbkd" + RandomSeed,
            Location = 0,
            Situation = 0,
            LocationNavigation = location,
            SituationNavigation = situation

        };
        TruckExternal truck = new() {
            Status = 1,
            Common = 0,
            UsaPlate = "usPlate" + RandomSeed,
            MxPlate = "mxPlate" + RandomSeed,
            Vin = "VIN " + RandomSeed,
            Carrier = "Carrier ext " + RandomSeed,
            TruckCommonNavigation = common,
        };

        return truck;
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
        Assert.True(Estela.Records.Length > 0);
        Assert.Equal(1, Estela.Page);
        Assert.True(Estela.Pages > 0);
    }

    [Fact]
    public async Task Create() {
        List<TruckExternal> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(MockFactory(iterationTag));
        }

        (HttpStatusCode Status, GenericFrame response) = await Post("Create", mockList, true);
        SetBatchOut<TruckExternal> estela = Framing<SuccessFrame<SetBatchOut<TruckExternal>>>(response).Estela;
        Assert.Equal(HttpStatusCode.OK, Status);
        Assert.Empty(estela.Failures);
    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            TruckExternal mock = MockFactory(testTag);
            (HttpStatusCode Status, GenericFrame Respone) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            RecordUpdateOut<TruckExternal> creationResult = Framing<SuccessFrame<RecordUpdateOut<TruckExternal>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            TruckExternal updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            #region generate a new record
            string testTag = Guid.NewGuid().ToString()[..3];
            TruckExternal mock = MockFactory(testTag);

            (HttpStatusCode Status, GenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<TruckExternal> creationResult = Framing<SuccessFrame<RecordUpdateOut<TruckExternal>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            TruckExternal creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.Vin, creationRecord.Vin),
            ]);
            #endregion

            #region update only main properties
            // Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            string modifiedVin = updatedTag + RandomUtils.String(12);
            mock = creationRecord;

            mock.Vin = modifiedVin;
            mock.TruckCommonNavigation!.Economic = "extEco" + updatedTag;
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<TruckExternal> updateResult = Framing<SuccessFrame<RecordUpdateOut<TruckExternal>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            TruckExternal updateRecord = updateResult.Updated;
            TruckExternal previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.MxPlate, updateRecord.MxPlate),
                () => Assert.NotEqual(previousRecord.Vin, updateRecord.Vin),
                () => Assert.NotEqual(previousRecord.TruckCommonNavigation!.Economic, updateRecord.TruckCommonNavigation!.Economic)
            ]);
            #endregion
        }
        #endregion
    }
    [Fact]
    public async Task Delete() {
        string testTag = Guid.NewGuid().ToString()[..3];
        List<TruckExternal> mock = [MockFactory(testTag)];

        // Create a new record to delete.
        (HttpStatusCode Status, GenericFrame response) = await Post("Create", mock, true);
        SetBatchOut<TruckExternal> estela = Framing<SuccessFrame<SetBatchOut<TruckExternal>>>(response).Estela;
        Assert.Equal(HttpStatusCode.OK, Status);
        Assert.Empty(estela.Failures);

        // Deleting the previous record.
        TruckExternal newAccount = estela.Successes.First();
        (HttpStatusCode DeleteStatus, _) = await Post("Delete", newAccount, true);
        Assert.Equal(HttpStatusCode.OK, DeleteStatus);

    }
}