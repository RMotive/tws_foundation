using System.Net;
using System.Text;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using TWS_Security.Sets;

using AuthAccount = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Security.Sets.Account>;

namespace TWS_Foundation.Quality.Suit.Controllers.Security;


public class Q_AccountsService
    : BQ_CustomServerController<Account> {

    public Q_AccountsService(WebApplicationFactory<Program> hostFactory)
        : base("Accounts", hostFactory) {
    }

    protected override Account MockFactory(string RandomSeed) {
        Account mock = new() {
            User = "mock " + RandomSeed,
            Password = Encoding.UTF8.GetBytes("mock" + RandomSeed),
            Wildcard = false,
            Contact = 0,
            ContactNavigation = new() {
                Name = "name " + RandomSeed,
                Lastname = "lastname" + RandomSeed,
                Email = "email@" + RandomSeed ,
                Phone = "6647151"+ RandomSeed,
            },
        };
        return mock;
    }

    protected override async Task<string> Authentication() {
        (HttpStatusCode Status, SuccessFrame<Session> Response) = await XPost<SuccessFrame<Session>, Credentials>("Security/Authenticate", new Credentials {
            Identity = AuthAccount.Identity,
            Password = AuthAccount.Password,
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
        List<Account> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(MockFactory(iterationTag));
        }

        (HttpStatusCode Status, GenericFrame response) = await Post("Create", mockList, true);
        SetBatchOut<Account> estela = Framing<SuccessFrame<SetBatchOut<Account>>>(response).Estela;
        Assert.Equal(HttpStatusCode.OK, Status);
        Assert.Empty(estela.Failures);
    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            Account mock = MockFactory(testTag);
            (HttpStatusCode Status, GenericFrame Respone) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            RecordUpdateOut<Account> creationResult = Framing<SuccessFrame<RecordUpdateOut<Account>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            Account updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            #region generate a new record
            string testTag = Guid.NewGuid().ToString()[..3];
            Account mock = MockFactory(testTag);

            (HttpStatusCode Status, GenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<Account> creationResult = Framing<SuccessFrame<RecordUpdateOut<Account>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            Account creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.True(mock.Password.SequenceEqual(creationRecord.Password)),
                () => Assert.Equal(mock.User, creationRecord.User),
                () => Assert.Equal(mock.ContactNavigation!.Name, creationRecord.ContactNavigation!.Name),
            ]);
            #endregion

            #region update only main properties
            //Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            mock = creationRecord;

            mock.User = updatedTag + RandomUtils.String(7);
            mock.ContactNavigation!.Name = updatedTag + RandomUtils.String(7);
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<Account> updateResult = Framing<SuccessFrame<RecordUpdateOut<Account>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            Account updateRecord = updateResult.Updated;
            Account previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.NotEqual(previousRecord.User, updateRecord.User),
                () => Assert.NotEqual(previousRecord.ContactNavigation!.Name, updateRecord.ContactNavigation!.Name),
            ]);
            #endregion
        }
        #endregion
    }
}