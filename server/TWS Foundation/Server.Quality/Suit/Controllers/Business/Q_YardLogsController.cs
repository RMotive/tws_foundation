
using System.Net;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Server.Records;

using CSM_Security.Entities.Accounts;
using CSM_Security.Entities.Solutions;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Entities;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Entities.YardLog>;


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
        VehiculeModel vehiculeModel = new() {
            Status = new Status { Id = 1 },
            Name = "Generic model " + RandomSeed,
            Manufacturer = manufacturer,
        };

        SCT sct = new() {
            Status = new Status { Id = 1 },
            Type = "TypT14",
            Number = "NumberSCTTesting value" + RandomSeed,
            Configuration = "Conf" + RandomSeed
        };
        Address addressCommon = new() {
            Street = "Truck Location " + RandomSeed,
            Country = "USA"
        };

        Approach contact = new() {
            Status = new Status { Id = 1 },
            EMail = "mail@test.com " + RandomSeed
        };

        Carrier carrier = new() {
            Name = "Carrier " + RandomSeed,
            Status = new Status {
                Id = 1,
            },
            Address = addressCommon,
            Approach = contact,
        };

        Plate plateMX = new() {
            Status = new Status { Id = 1 },
            Identifier = "mxPlate" + RandomSeed,
            State = "BAC",
            Country = "MXN",
            Expiration = date,
        };
        Plate plateUSA = new() {
            Status = new Status { Id = 1 },
            Identifier = "usaPlate" + RandomSeed,
            State = "CaA",
            Country = "USA",
            Expiration = date,
        };
        TruckCommon common = new() {
            Status = new Status {
                Id = 1,
            },
            Economic = "EconomicTbkd" + RandomSeed,
        };

        List<Plate> plateList = [plateMX, plateUSA];
        TrailerCommon trailerCommon = new() {
            Economic = "TrailerEco " + RandomSeed,
        };
        Trailer trailer = new() {
            Carrier = new Carrier {
                Id = 1,
            },
            Common = trailerCommon,
        };
        Truck truck = new() {
            Motor = motor,
            VIN = "VINtestcTbkd" + RandomSeed,
            Model = vehiculeModel,
            Carrier = carrier,
            Common = common,
            SCT = sct,
            Plates = plateList,
        };
        Section section = new() {
            Yard = new Location { Id = 1 },
            Name = "section " + RandomSeed,
            Capacity = 30,
            Ocupancy = 1,
            Timestamp = DateTime.UtcNow,
        };
        YardLog mock = new() {
            Entry = true,
            LoadType = new LoadType {
                Id = 1,
            },
            Guard = new TWS_Business.Entities.Employees.Employee {
                Id = 1,
            },
            Trailer = new TrailerCommon {
                Internal = trailer
            },
            Seal = "seal " + iterationTag,
            SealAlt = "seal Alternative " + iterationTag,
            Section = section,
            FromTo = "Cocacola florido " + iterationTag,
            Driver = new DriverCommon {
                Id = 1,
            },
            Truck = new TruckCommon {
                Id = truck.Common.Id,
                Internal = truck
            },
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
        Assert.True(Estela.Records.Length > 0);
        Assert.Equal(1, Estela.Page);
        Assert.True(Estela.Pages > 0);
    }

    [Fact]
    public async Task Create() {
        List<YardLog> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            mockList.Add(MockFactory(testTag + i));
        }

        (HttpStatusCode Status, GenericFrame _) = await Post("Create", mockList, true);
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
            EntityUpdateOut<Solution> creationResult = Framing<SuccessFrame<EntityUpdateOut<Solution>>>(Respone).Estela;

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

            EntityUpdateOut<YardLog> creationResult = Framing<SuccessFrame<EntityUpdateOut<YardLog>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            YardLog creationRecord = creationResult.Updated;
            Assert.Multiple();
            mock = creationRecord.DeepCopy();
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            EntityUpdateOut<YardLog> updateResult = Framing<SuccessFrame<EntityUpdateOut<YardLog>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            Assert.Multiple();
        }
        #endregion
    }
}