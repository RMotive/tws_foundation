
using System.Net;

using CSM_Foundation.Server.Records;
using CSM_Foundation.Databases.Models.Options;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Middlewares.Frames;

using TWS_Business.Sets;

using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Records;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Databases.Models.Out.SetViewOut<TWS_Business.Sets.Truck>;
using TWS_Foundation.Quality.Bases;
using CSM_Foundation.Databases.Models.Out;
using CSM_Foundation.Core.Utils;
namespace TWS_Foundation.Quality.Suit.Controllers;
public class Q_TrucksController : BQ_CustomServerController {


    public Q_TrucksController(WebApplicationFactory<Program> hostFactory) : base("Trucks", hostFactory) {
    }

    protected override async Task<string> Authentication() {
        (HttpStatusCode Status, SuccessFrame<Session> Response) = await XPost<SuccessFrame<Session>, Credentials>("Security/Authenticate", new Credentials {
            Identity = Account.Identity,
            Password = Account.Password,
            Sign = "TWSMA"
        });

        return Status != HttpStatusCode.OK ? throw new ArgumentNullException(nameof(Status)) : Response.Estela.Token.ToString();
    }

    private static Truck BuildTruck(string tag) {
        DateOnly date = new(2024, 12, 12);
        string motor = "motortestbkd" + tag;
        Manufacturer manufacturer = new() {
            Model = "X23 " + tag,
            Brand = "SCANIA TEST",
            Year = date
        };
        Insurance insurance = new() {
            Status = 1,
            Policy = "P232Policy" + tag,
            Expiration = date,
            Country = "MEX"
        };
        Situation situation = new() {
            Name = "Situational test " + tag,
            Description = "Description test " + tag
        };
        Maintenance maintenance = new() {
            Status = 1,
            Anual = date,
            Trimestral = date,
        };
        Sct sct = new() {
            Status = 1,
            Type = "TypT14",
            Number = "NumberSCTTesting value" + tag,
            Configuration = "Conf" + tag
        };
        Address address = new() {
            Street = "Main street " + tag,
            Country = "USA"
        };
        Address addressCommon = new() {
            Street = "Truck Location " + tag,
            Country = "USA"
        };

        Usdot usdot = new() {
            Status = 1,
            Mc = "mc- " + tag,
            Scac = "s" + tag
        };

        Approach contact = new() {
            Status = 1,
            Email = "mail@test.com " + tag
        };

        Carrier carrier = new() {
            Status = 1,
            Name = "Carrier " + tag,
            Approach = 0,
            Address = 0,
            AddressNavigation = addressCommon,
            ApproachNavigation = contact,
            UsdotNavigation = usdot,
            SctNavigation = sct
        };

        Plate plateMX = new() {
            Status = 1,
            Identifier = "mxPlate" + tag,
            State = "BAC",
            Country = "MXN",
            Expiration = date,
        };
        Plate plateUSA = new() {
            Status = 1,
            Identifier = "usaPlate" + tag,
            State = "CaA",
            Country = "USA",
            Expiration = date,
        };
        Location location = new() {
            Name = "random location: " + tag,
            Status = 1,
            Address = 0,
            AddressNavigation = address,
        };
        TruckCommon common = new() {
            Status = 1,
            Vin = "VINtestcTbkd" + tag,
            Economic = "EconomicTbkd" + tag,
            Location = 0,
            Situation = 0,
            LocationNavigation = location,
            SituationNavigation = situation

        };

        List<Plate> plateList = [plateMX, plateUSA];
        Truck truck = new() {
            Status = 1,
            Carrier = 0,
            Common = 0,
            Manufacturer = 0,
            Motor = motor,
            ManufacturerNavigation = manufacturer,
            CarrierNavigation = carrier,
            InsuranceNavigation = insurance,
            TruckCommonNavigation = common,
            MaintenanceNavigation = maintenance,
            Plates = plateList,
        };
        return truck;
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
        List<Truck> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(BuildTruck(iterationTag));
        }
        (HttpStatusCode Status, ServerGenericFrame response) = await Post("Create", mockList, true);
        Assert.Equal(HttpStatusCode.OK, Status);

    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            Truck mock = BuildTruck(testTag);
            (HttpStatusCode Status, ServerGenericFrame Respone) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            RecordUpdateOut<Truck> creationResult = Framing<SuccessFrame<RecordUpdateOut<Truck>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            Truck updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            #region generate a new record
            string testTag = Guid.NewGuid().ToString()[..3];
            Truck mock = BuildTruck(testTag);

            (HttpStatusCode Status, ServerGenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<Truck> creationResult = Framing<SuccessFrame<RecordUpdateOut<Truck>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            Truck creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.TruckCommonNavigation!.Vin, creationRecord.TruckCommonNavigation!.Vin),
                () => Assert.Equal(mock.Motor, creationRecord.Motor),
            ]);
            #endregion

            #region update only main properties
            // Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            string modifiedVin = updatedTag + RandomUtils.String(12);
            string modifiedMotor = updatedTag + RandomUtils.String(11);
            mock = creationRecord;

            mock.TruckCommonNavigation!.Vin = modifiedVin;
            mock.Motor = modifiedMotor;
            Plate plate = mock.Plates.First();
            plate.Identifier = "identfy" + updatedTag;
            (HttpStatusCode Status, ServerGenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<Truck> updateResult = Framing<SuccessFrame<RecordUpdateOut<Truck>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            Truck updateRecord = updateResult.Updated;
            Truck previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.Manufacturer, updateRecord.Manufacturer),
                () => Assert.Equal(creationRecord.CarrierNavigation?.Id, updateRecord.CarrierNavigation?.Id),
                () => Assert.NotEqual(previousRecord.TruckCommonNavigation!.Vin, updateRecord.TruckCommonNavigation!.Vin),
                () => Assert.NotEqual(previousRecord.Plates.First().Identifier, updateRecord.Plates.First().Identifier),
                () => Assert.NotEqual(previousRecord.Motor, updateRecord.Motor)
            ]);
            #endregion
        }
    }
    #endregion
}