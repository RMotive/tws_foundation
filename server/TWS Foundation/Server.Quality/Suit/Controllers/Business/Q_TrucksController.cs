using System.Net;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Entities;

using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Records;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using Account = TWS_Foundation.Quality.Secrets.Account;
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Entities.Truck>;

namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_TrucksController : BQ_CustomServerController<Truck> {


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

    protected override Truck MockFactory(string RandomSeed) {
        DateOnly date = new(2024, 12, 12);
        string motor = "motortestbkd" + RandomSeed;
        Manufacturer manufacturer = new() {
            Name = "SCANIA " + RandomSeed,
            Description = "DESC " + RandomSeed
        };
        VehiculeModel vehiculeModel = new() {
            Status = 1,
            Name = "Generic model " + RandomSeed,
            ManufacturerNavigation = manufacturer,
        };
        Insurance insurance = new() {
            Status = 1,
            Policy = "P232Policy" + RandomSeed,
            Expiration = date,
            Country = "MEX"
        };
        Situation situation = new() {
            Name = "Situational test " + RandomSeed,
            Description = "Description test " + RandomSeed
        };
        Maintenance maintenance = new() {
            Status = 1,
            Anual = date,
            Trimestral = date,
        };
        Sct sct = new() {
            Status = 1,
            Type = "TypT14",
            Number = "NumberSCTTesting value" + RandomSeed,
            Configuration = "Conf" + RandomSeed
        };
        Address address = new() {
            Street = "Main street " + RandomSeed,
            Country = "USA"
        };
        Address addressCommon = new() {
            Street = "Truck Location " + RandomSeed,
            Country = "USA"
        };

        USDOT usdot = new() {
            Status = 1,
            Mc = "mc- " + RandomSeed,
            Scac = "s" + RandomSeed
        };

        Approach contact = new() {
            Status = 1,
            Email = "mail@test.com " + RandomSeed
        };

        Carrier carrier = new() {
            Name = "Carrier " + RandomSeed,
            Status = new Status {
                Id = 1,
            },
            Address = addressCommon,
            Approach = contact,
            USDOT = usdot,
        };

        Plate plateMX = new() {
            Status = 1,
            Identifier = "mxPlate" + RandomSeed,
            State = "BAC",
            Country = "MXN",
            Expiration = date,
        };
        Plate plateUSA = new() {
            Status = 1,
            Identifier = "usaPlate" + RandomSeed,
            State = "CaA",
            Country = "USA",
            Expiration = date,
        };
        Location location = new() {
            Name = "random location: " + RandomSeed,
            Status = new Status {
                Id = 1,
            },
            Address = address,
        };
        TruckCommon common = new() {
            Status = 1,
            Economic = "EconomicTbkd" + RandomSeed,
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
            Model = 0,
            Motor = motor,
            Vin = "VIN " + RandomSeed,
            VehiculeModelNavigation = vehiculeModel,
            CarrierNavigation = carrier,
            InsuranceNavigation = insurance,
            TruckCommonNavigation = common,
            MaintenanceNavigation = maintenance,
            SctNavigation = sct,
            Plates = plateList,
        };
        return truck;
    }
    [Fact]
    public async Task View() {
        (HttpStatusCode Status, GenericFrame Response) = await Post("View", new SetViewOptions<TWS_Security.Entities.Accounts.Account> {
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
        List<Truck> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(MockFactory(iterationTag));
        }
        (HttpStatusCode Status, GenericFrame _) = await Post("Create", mockList, true);
        Assert.Equal(HttpStatusCode.OK, Status);

    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            Truck mock = MockFactory(testTag);
            (HttpStatusCode Status, GenericFrame Respone) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            EntityUpdateOut<Truck> creationResult = Framing<SuccessFrame<EntityUpdateOut<Truck>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            Truck updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            #region generate a new record
            string testTag = Guid.NewGuid().ToString()[..3];
            Truck mock = MockFactory(testTag);

            (HttpStatusCode Status, GenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            EntityUpdateOut<Truck> creationResult = Framing<SuccessFrame<EntityUpdateOut<Truck>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            Truck creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.Vin, creationRecord.Vin),
                () => Assert.Equal(mock.Motor, creationRecord.Motor),
            ]);
            #endregion

            #region update only main properties
            // Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            string modifiedVin = updatedTag + RandomUtils.String(12);
            string modifiedMotor = updatedTag + RandomUtils.String(11);
            mock = creationRecord;

            mock.Vin = modifiedVin;
            mock.Motor = modifiedMotor;
            mock.TruckCommonNavigation!.Economic = modifiedMotor;
            Plate plate = mock.Plates.First();
            plate.Identifier = "identfy" + updatedTag;
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            EntityUpdateOut<Truck> updateResult = Framing<SuccessFrame<EntityUpdateOut<Truck>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            Truck updateRecord = updateResult.Updated;
            Truck previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.Model, updateRecord.Model),
                () => Assert.Equal(creationRecord.CarrierNavigation?.Id, updateRecord.CarrierNavigation?.Id),
                () => Assert.NotEqual(previousRecord.Vin, updateRecord.Vin),
                () => Assert.NotEqual(previousRecord.Plates.First().Identifier, updateRecord.Plates.First().Identifier),
                () => Assert.NotEqual(previousRecord.Motor, updateRecord.Motor),
                () => Assert.NotEqual(previousRecord.TruckCommonNavigation!.Economic, updateRecord.TruckCommonNavigation!.Economic)
            ]);
            #endregion
        }
    }
    #endregion
}