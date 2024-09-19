
using System.Net;

using CSM_Foundation.Server.Quality.Bases;
using CSM_Foundation.Server.Records;
using CSM_Foundation.Databases.Models.Options;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Middlewares.Frames;

using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Records;

using Xunit;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Databases.Models.Out.SetViewOut<TWS_Business.Sets.TruckExternal>;
using TWS_Business.Sets;
using CSM_Foundation.Core.Utils;
using CSM_Foundation.Databases.Models.Out;


namespace TWS_Foundation.Quality.Suit.Controllers;
public class Q_TrucksExternalsController : BQ_ServerController<Program> {
    private class Frame : SuccessFrame<View> { }


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

    private static TruckExternal BuildExternalTruck(string tag) {
        Address address = new() {
            Street = "Main E street " + tag,
            Country = "USA"
        };
        Situation situation = new() {
            Name = "Situational E " + tag,
            Description = "Description E test " + tag
        };
        Location location = new() {
            Name = "random E location: " + tag,
            Status = 1,
            Address = 0,
            AddressNavigation = address,
        };
        TruckCommon common = new() {
            Status = 1,
            Economic = "ExternalECON" + tag,
            Location = 0,
            LocationNavigation = location,
            SituationNavigation = situation,
        };
        TruckExternal external = new() { 
            Status = 1,
            Common = 0,
            Carrier = "ECarrier" + tag,
            MxPlate = "EmxPlate" + tag,
            UsaPlate = "EsaPlate" + tag,
            TruckCommonNavigation = common

        };
        return external;
    }   


    [Fact]
    public async Task View() {
        (HttpStatusCode Status, ServerGenericFrame Response) = await Post("View", new SetViewOptions {
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
        List<TruckExternal> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(BuildExternalTruck(iterationTag));
        }
        (HttpStatusCode Status, ServerGenericFrame response) = await Post("Create", mockList, true);
        Assert.Equal(HttpStatusCode.OK, Status);

    }


    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            TruckExternal mock = BuildExternalTruck(testTag);
            (HttpStatusCode Status, ServerGenericFrame Respone) = await Post("Update", mock, true);

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
            TruckExternal mock = BuildExternalTruck(testTag);

            (HttpStatusCode Status, ServerGenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<TruckExternal> creationResult = Framing<SuccessFrame<RecordUpdateOut<TruckExternal>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            TruckExternal creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.MxPlate, creationRecord.MxPlate),
            ]);
            #endregion

            #region update only main properties
            // Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            string modifiedEconomic = updatedTag + RandomUtils.String(11);
            mock = creationRecord;

            mock.MxPlate = "identfy" + updatedTag;
            mock.Carrier = "Carrier" + updatedTag + RandomUtils.String(5);
            mock.TruckCommonNavigation!.Economic = modifiedEconomic;
            (HttpStatusCode Status, ServerGenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<TruckExternal> updateResult = Framing<SuccessFrame<RecordUpdateOut<TruckExternal>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            TruckExternal updateRecord = updateResult.Updated;
            TruckExternal previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.TruckCommonNavigation!.Id, updateRecord.TruckCommonNavigation!.Id),
                () => Assert.NotEqual(previousRecord.MxPlate, updateRecord.UsaPlate),
                () => Assert.NotEqual(previousRecord.Carrier, updateRecord.Carrier),
                () => Assert.NotEqual(previousRecord.TruckCommonNavigation!.Economic, updateRecord.TruckCommonNavigation!.Economic)
            ]);
            #endregion
        }
    }
    #endregion

}
