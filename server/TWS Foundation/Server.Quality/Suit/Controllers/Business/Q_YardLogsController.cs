
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

using TWS_Security.Sets;

using static System.Runtime.InteropServices.JavaScript.JSType;

using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.YardLog>;


namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_YardLogsController : BQ_CustomServerController<YardLog> {
    private class Frame : SuccessFrame<View> { }


    public Q_YardLogsController(WebApplicationFactory<Program> hostFactory)
        : base("YardLogs", hostFactory) {
    }

    protected override YardLog MockFactory(string RandomSeed) {
        string iterationTag = RandomSeed;
        DateOnly date = new(2024, 12, 12);

        string motor = "motortestbkd" + RandomSeed;
        Manufacturer manufacturer = new() {
            Name = "SCANIA " + RandomSeed,
            Description = "DESC " + RandomSeed
        };
        VehiculeModel vehiculeModel = new VehiculeModel() {
            Status = 1,
            Name = "Generic model " + RandomSeed,
            ManufacturerNavigation = manufacturer,
        };
       
        Sct sct = new() {
            Status = 1,
            Type = "TypT14",
            Number = "NumberSCTTesting value" + RandomSeed,
            Configuration = "Conf" + RandomSeed
        };
        Address addressCommon = new() {
            Street = "Truck Location " + RandomSeed,
            Country = "USA"
        };

        Approach contact = new() {
            Status = 1,
            Email = "mail@test.com " + RandomSeed
        };

        Carrier carrier = new() {
            Status = 1,
            Name = "Carrier " + RandomSeed,
            Approach = 0,
            Address = 0,
            AddressNavigation = addressCommon,
            ApproachNavigation = contact,
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
        TruckCommon common = new() {
            Status = 1,
            Economic = "EconomicTbkd" + RandomSeed,
        };

        List<Plate> plateList = [plateMX, plateUSA];

        Truck truck = new() {
            Status = 1,
            Carrier = 0,
            Common = 0,
            Model = 0,
            Motor = motor,
            Vin = "VINtestcTbkd" + RandomSeed,
            VehiculeModelNavigation = vehiculeModel,
            CarrierNavigation = carrier,
            TruckCommonNavigation = common,
            SctNavigation = sct,
            Plates = plateList,
        };
        Section section = new() {
            Status = 1,
            Yard = 1,
            Name = "section " + RandomSeed,
            Capacity = 30,
            Ocupancy = 1,
            Timestamp = DateTime.UtcNow,
        };
        YardLog mock = new() {
            Entry = true,
            Truck = 0,
            LoadType = 1,
            Guard = 1,
            Gname = "Enrique" + iterationTag,
            Section = 0,
            SectionNavigation = section,
            Seal = "Seal " + iterationTag,
            FromTo = "Cocacola florido " + iterationTag,
            Damage = false,
            TTPicture = "Foto " + iterationTag,
            Driver = 1,
            TruckNavigation = truck,
        };
        return mock;

    }

    [Fact]
    public async Task View() {
        (HttpStatusCode Status, GenericFrame Response) = await Post("View", new SetViewOptions<Account> {
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
        List<YardLog> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            mockList.Add(MockFactory(testTag+i));
        }

        (HttpStatusCode Status, _) = await Post("Create", mockList, true);
        Assert.Equal(HttpStatusCode.OK, Status);

    }

    [Fact]
    public async Task Update() {
        string tag = RandomUtils.String(3);
        #region First (Correctly creates when doesn't exist)
        {
            YardLog mock = MockFactory(tag);

            (HttpStatusCode Status, GenericFrame Respone) = await Post("Update", mock, true);

            Assert.True(HttpStatusCode.OK.Equals(Status));
            RecordUpdateOut<Solution> creationResult = Framing<SuccessFrame<RecordUpdateOut<Solution>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            Solution updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            tag = "U" + RandomUtils.String(2);
            YardLog mock = MockFactory(tag);
            (HttpStatusCode Status, GenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<YardLog> creationResult = Framing<SuccessFrame<RecordUpdateOut<YardLog>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            YardLog creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.Gname, creationRecord.Gname),
                () => Assert.Equal(mock.FromTo, creationRecord.FromTo),
                () => Assert.Equal(mock.TTPicture, creationRecord.TTPicture),
                () => Assert.Equal(mock.SectionNavigation!.Name, creationRecord.SectionNavigation!.Name),
            ]);
            mock = creationRecord.DeepCopy();
            mock.Gname = "UPDATED" + RandomUtils.String(10);
            mock.SectionNavigation!.Name = "UPT" + RandomUtils.String(10);
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<YardLog> updateResult = Framing<SuccessFrame<RecordUpdateOut<YardLog>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            YardLog updateRecord = updateResult.Updated;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.FromTo, updateRecord.FromTo),
                () => Assert.Equal(creationRecord.TTPicture, updateRecord.TTPicture),
                () => Assert.NotEqual(creationRecord.Gname, updateRecord.Gname),
                () => Assert.NotEqual(creationRecord.SectionNavigation!.Name, updateRecord.SectionNavigation!.Name),
            ]);
        }
        #endregion
    }
}