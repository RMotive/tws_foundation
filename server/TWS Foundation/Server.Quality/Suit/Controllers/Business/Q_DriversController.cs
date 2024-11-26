using System.Net;

using Azure;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Sets;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.Driver>;

namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_DriversController
    : BQ_CustomServerController<Driver> {

    public Q_DriversController(WebApplicationFactory<Program> hostFactory)
        : base("Drivers", hostFactory) {
    }

    protected override Driver MockFactory(string RandomSeed) {
        DateTime time = DateTime.Now;
        DateOnly date = DateOnly.MaxValue;
        return new Driver() {
            Id = 0,
            Timestamp = time,
            Status = 1,
            Employee = 0,
            Common = 0,
            DriverType = "d Type" + RandomSeed,
            LicenseExpiration = date,
            DrugalcRegistrationDate = date,
            PullnoticeRegistrationDate = date,
            TwicExpiration = date,
            VisaExpiration = date,
            FastExpiration = date,
            AnamExpiration = date,
            Twic = RandomUtils.String(12),
            Visa = RandomUtils.String(12),
            Fast = RandomUtils.String(14),
            Anam = RandomUtils.String(24),
            DriverCommonNavigation = new (){
                Id = 0,
                Timestamp = time,
                Status = 1,
                License = RandomUtils.String(12),
            },
            EmployeeNavigation = new (){
                Id = 0,
                Timestamp = time,
                Status = 1,
                Identification = 0,
                Address = 0,
                Approach = 0,
                Curp = RandomUtils.String(18),
                Rfc = RandomUtils.String(12),
                Nss = RandomUtils.String(11),
                ApproachNavigation = new() {
                    Status = 1,
                    Email = "mail@test.com " + RandomSeed
                },
                AddressNavigation = new() {
                    Street = "Driver residence location " + RandomSeed,
                    Country = "USA"
                },
                IdentificationNavigation = new() {
                    Id = 0,
                    Timestamp = time,
                    Status = 1,
                    Name = RandomUtils.String(12) + RandomSeed,
                    FatherLastname = "Father lastname " + RandomSeed,
                    MotherLastName = "Mother lastname " + RandomSeed ,
                }
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
        List<Driver> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(MockFactory(iterationTag));
        }

        (HttpStatusCode Status, GenericFrame response) = await Post("Create", mockList, true);
        SetBatchOut<Driver> estela = Framing<SuccessFrame<SetBatchOut<Driver>>>(response).Estela;
        Assert.Equal(HttpStatusCode.OK, Status);
        Assert.Empty(estela.Failures);
    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            Driver mock = MockFactory(testTag);
            (HttpStatusCode Status, GenericFrame Respone) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            RecordUpdateOut<Driver> creationResult = Framing<SuccessFrame<RecordUpdateOut<Driver>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            Driver updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            #region generate a new record
            string testTag = Guid.NewGuid().ToString()[..3];
            Driver mock = MockFactory(testTag);

            (HttpStatusCode Status, GenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<Driver> creationResult = Framing<SuccessFrame<RecordUpdateOut<Driver>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            Driver creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.Visa, creationRecord.Visa),
                () => Assert.Equal(mock.DriverCommonNavigation!.License, creationRecord.DriverCommonNavigation!.License),
            ]);
            #endregion

            #region update only main properties
            //Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            mock = creationRecord;

            mock.Visa = updatedTag + RandomUtils.String(7);
            mock.DriverCommonNavigation!.License = updatedTag + RandomUtils.String(7);
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<Driver> updateResult = Framing<SuccessFrame<RecordUpdateOut<Driver>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            Driver updateRecord = updateResult.Updated;
            Driver previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.Twic, updateRecord.Twic),
                () => Assert.NotEqual(previousRecord.Visa, updateRecord.Visa),
                () => Assert.NotEqual(previousRecord.DriverCommonNavigation!.License, updateRecord.DriverCommonNavigation!.License),
            ]);
            #endregion
        }
        #endregion
    }

}