
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
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.DriverExternal>;


namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_DriversExternalsController : BQ_CustomServerController<DriverExternal> {

    public Q_DriversExternalsController(WebApplicationFactory<Program> hostFactory)
        : base("DriversExternals", hostFactory) {
    }

    protected override DriverExternal MockFactory(string RandomSeed) {
        DateTime time = DateTime.Now;
        DateOnly date = DateOnly.MaxValue;
        return new DriverExternal {
            Id = 0,
            Timestamp = time,
            Status = 1,
            Identification = 0,
            Common = 0,
            DriverCommonNavigation = new() {
                Id = 0,
                Timestamp = time,
                Status = 1,
                License = RandomUtils.String(12),
            },
            IdentificationNavigation = new() {
                Id = 0,
                Timestamp = time,
                Status = 1,
                Name = RandomUtils.String(12) + RandomSeed,
                FatherLastname = "Father lastname " + RandomSeed,
                MotherLastName = "Mother lastname " + RandomSeed,
            }
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
        List<DriverExternal> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(MockFactory(iterationTag));
        }

        (HttpStatusCode Status, GenericFrame response) = await Post("Create", mockList, true);
        SetBatchOut<DriverExternal> estela = Framing<SuccessFrame<SetBatchOut<DriverExternal>>>(response).Estela;
        Assert.Equal(HttpStatusCode.OK, Status);
        Assert.Empty(estela.Failures);
    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            DriverExternal mock = MockFactory(testTag);
            (HttpStatusCode Status, GenericFrame Respone) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            RecordUpdateOut<DriverExternal> creationResult = Framing<SuccessFrame<RecordUpdateOut<DriverExternal>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            DriverExternal updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            #region generate a new record
            string testTag = Guid.NewGuid().ToString()[..3];
            DriverExternal mock = MockFactory(testTag);

            (HttpStatusCode Status, GenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<DriverExternal> creationResult = Framing<SuccessFrame<RecordUpdateOut<DriverExternal>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            DriverExternal creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.IdentificationNavigation!.Name, creationRecord.IdentificationNavigation!.Name),
                () => Assert.Equal(mock.DriverCommonNavigation!.License, creationRecord.DriverCommonNavigation!.License),
            ]);
            #endregion

            #region update only main properties
            //Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            mock = creationRecord;

            mock.IdentificationNavigation!.Name = "name " + updatedTag + RandomUtils.String(7);
            mock.DriverCommonNavigation!.License = updatedTag + RandomUtils.String(7);
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<DriverExternal> updateResult = Framing<SuccessFrame<RecordUpdateOut<DriverExternal>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            DriverExternal updateRecord = updateResult.Updated;
            DriverExternal previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.IdentificationNavigation!.Id, updateRecord.IdentificationNavigation!.Id),
                () => Assert.NotEqual(previousRecord.IdentificationNavigation!.Name, updateRecord.IdentificationNavigation!.Name),
                () => Assert.NotEqual(previousRecord.DriverCommonNavigation!.License, updateRecord.DriverCommonNavigation!.License),
            ]);
            #endregion
        }
        #endregion
    }
}