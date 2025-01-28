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
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.TrailerExternal>;


namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_TrailersExternalsController
    : BQ_CustomServerController<TrailerExternal> {

    public Q_TrailersExternalsController(WebApplicationFactory<Program> hostFactory)
        : base("TrailersExternals", hostFactory) {
    }

    protected override async Task<string> Authentication() {
        (HttpStatusCode Status, SuccessFrame<Session> Response) = await XPost<SuccessFrame<Session>, Credentials>("Security/Authenticate", new Credentials {
            Identity = Account.Identity,
            Password = Account.Password,
            Sign = "TWSMA"
        });

        return Status != HttpStatusCode.OK ? throw new ArgumentNullException(nameof(Status)) : Response.Estela.Token.ToString();
    }

    protected override TrailerExternal MockFactory(string RandomSeed) {
        TrailerExternal mock = new() {
            Id = 0,
            Timestamp = DateTime.Now,
            Status = 1,
            Common = 0,
            Carrier = RandomUtils.String(9) + RandomSeed,
            MxPlate = RandomUtils.String(9) + RandomSeed,
            UsaPlate = RandomUtils.String(9) + RandomSeed,
            TrailerCommonNavigation = new() {
                Id = 0,
                Timestamp = DateTime.Now,
                Status = 1,
                Economic = RandomUtils.String(13) + RandomSeed,
                TrailerTypeNavigation = new() {
                    Id = 0,
                    Timestamp = DateTime.Now,
                    Status = 1,
                    Size = RandomUtils.String(6),
                    TrailerClass = 0,
                    TrailerClassNavigation = new() {
                        Id = 0,
                        Timestamp= DateTime.Now,
                        Name = RandomUtils.String(10) + RandomSeed,
                    }
                },
                SituationNavigation = new() { 
                    Id = 0,
                    Timestamp = DateTime.Now,
                    Name = RandomUtils.String(10) + RandomSeed,
                },
                LocationNavigation = new() {
                    Id = 0,
                    Timestamp = DateTime.Now,
                    Name = RandomUtils.String(10) + RandomSeed,
                    Status = 1,
                    Address = 0,
                    AddressNavigation = new() { 
                        Id = 0,
                        Timestamp = DateTime.Now,
                        Country = "USA"
                    }
                }
            }
        };
        return mock;
    }

    [Fact]
    public async Task View() {
        (HttpStatusCode Status, GenericFrame Response) = await Post("View", new SetViewOptions<TWS_Security.Sets.Account> {
            Page = 1,
            Range = 9,
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
        List<TrailerExternal> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(MockFactory(iterationTag));
        }
        (HttpStatusCode Status, GenericFrame response) = await Post("Create", mockList, true);
        SetBatchOut<TrailerExternal> estela = Framing<SuccessFrame<SetBatchOut<TrailerExternal>>>(response).Estela;
        Assert.Equal(HttpStatusCode.OK, Status);
        Assert.Empty(estela.Failures);
    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            TrailerExternal mock = MockFactory(testTag);
            (HttpStatusCode Status, GenericFrame Respone) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            RecordUpdateOut<TrailerExternal> creationResult = Framing<SuccessFrame<RecordUpdateOut<TrailerExternal>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            TrailerExternal updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            #region generate a new record
            string testTag = Guid.NewGuid().ToString()[..3];
            TrailerExternal mock = MockFactory(testTag);

            (HttpStatusCode Status, GenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<TrailerExternal> creationResult = Framing<SuccessFrame<RecordUpdateOut<TrailerExternal>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            TrailerExternal creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.Carrier, creationRecord.Carrier),
            ]);
            #endregion

            #region update only main properties
            // Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            string modifiedCarrier = updatedTag + "Carrier" +RandomUtils.String(12);
            string modifiedUsaPlate = updatedTag + RandomUtils.String(7);
            string modifiedEco = updatedTag + "ECO" + RandomUtils.String(8);

            mock = creationRecord;

            mock.Carrier = modifiedCarrier;
            mock.UsaPlate = modifiedUsaPlate;
            mock.TrailerCommonNavigation!.Economic = modifiedEco;
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<TrailerExternal> updateResult = Framing<SuccessFrame<RecordUpdateOut<TrailerExternal>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            TrailerExternal updateRecord = updateResult.Updated;
            TrailerExternal previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.MxPlate, updateRecord.MxPlate),
                () => Assert.NotEqual(previousRecord.Carrier, updateRecord.Carrier),
                () => Assert.NotEqual(previousRecord.UsaPlate, updateRecord.UsaPlate),
                () => Assert.NotEqual(previousRecord.TrailerCommonNavigation!.Economic, updateRecord.TrailerCommonNavigation!.Economic),
            ]);
            #endregion
        }
        #endregion
    }
}