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
using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Business.Sets.Trailer>;


namespace TWS_Foundation.Quality.Suit.Controllers.Business;
public class Q_TrailersController
    : BQ_CustomServerController<Trailer> {

    public Q_TrailersController(WebApplicationFactory<Program> hostFactory)
        : base("Trailers", hostFactory) {
    }

    protected override async Task<string> Authentication() {
        (HttpStatusCode Status, SuccessFrame<Session> Response) = await XPost<SuccessFrame<Session>, Credentials>("Security/Authenticate", new Credentials {
            Identity = Account.Identity,
            Password = Account.Password,
            Sign = "TWSMA"
        });

        return Status != HttpStatusCode.OK ? throw new ArgumentNullException(nameof(Status)) : Response.Estela.Token.ToString();
    }

    protected override Trailer MockFactory(string RandomSeed) {
        DateOnly date = new(2009, 12, 12);
        Trailer mock = new() {
            Id = 0,
            Status = 1,
            Common = 0,
            Carrier = 0,
            SctNavigation = new() {
                Id = 0,
                Status = 1,
                Type = RandomUtils.String(6),   
                Number = RandomUtils.String(25),
                Configuration = RandomUtils.String(6)
            },
            CarrierNavigation = new() {
                Status = 1,
                Name = "Carrier " + RandomSeed,
                Approach = 0,
                Address = 0,
                AddressNavigation = new() {
                    Street = "Truck Location " + RandomSeed,
                    Country = "USA"
                },
                ApproachNavigation = new() {
                    Status = 1,
                    Email = "mail@test.com " + RandomSeed
                },
                UsdotNavigation = new() {
                    Status = 1,
                    Mc = "mc- " + RandomSeed,
                    Scac = "s" + RandomSeed
                },
            },
            TrailerCommonNavigation = new() {
                Id = 0,
                Status = 1,
                Economic = RandomUtils.String(13) + RandomSeed,
                TrailerTypeNavigation = new() {
                    Id = 0,
                    Status = 1,
                    Size = RandomUtils.String(6),
                    TrailerClass = 0,
                    TrailerClassNavigation = new() {
                        Id = 0,
                        Name = RandomUtils.String(10) + RandomSeed,
                    }
                },
                SituationNavigation = new() {
                    Id = 0,
                    Name = RandomUtils.String(10) + RandomSeed,
                },
                LocationNavigation = new() {
                    Id = 0,
                    Name = RandomUtils.String(10) + RandomSeed,
                    Status = 1,
                    Address = 0,
                    AddressNavigation = new() {
                        Id = 0,
                        Country = "USA"
                    },
                },
            },
            VehiculeModelNavigation = new() {
                Status = 1,
                Name = "Generic model " + RandomSeed,
                ManufacturerNavigation = new() {
                    Name = "SCANIA " + RandomSeed,
                    Description = "DESC " + RandomSeed
                },
            },
            MaintenanceNavigation = new() {
                Status = 1,
                Anual = date,
                Trimestral = date,
            },
            Plates = [
                new() {
                    Status = 1,
                    Identifier = "usaPlate" + RandomSeed,
                    State = "CaA",
                    Country = "USA",
                    Expiration = date,
                },
                new() {
                    Status = 1,
                    Identifier = "mxPlate" + RandomSeed,
                    State = "BAC",
                    Country = "MXN",
                    Expiration = date,
                }
            ]
        };
        return mock;
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
        List<Trailer> mockList = [];
        string testTag = Guid.NewGuid().ToString()[..2];

        for (int i = 0; i < 3; i++) {
            string iterationTag = testTag + i;
            mockList.Add(MockFactory(iterationTag));
        }
        (HttpStatusCode Status, GenericFrame response) = await Post("Create", mockList, true);
        SetBatchOut<Trailer> estela = Framing<SuccessFrame<SetBatchOut<Trailer>>>(response).Estela;
        Assert.Equal(HttpStatusCode.OK, Status);
        Assert.Empty(estela.Failures);
    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            string testTag = Guid.NewGuid().ToString()[..3];
            Trailer mock = MockFactory(testTag);
            (HttpStatusCode Status, GenericFrame Respone) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            RecordUpdateOut<Trailer> creationResult = Framing<SuccessFrame<RecordUpdateOut<Trailer>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            Trailer updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            #region generate a new record
            string testTag = Guid.NewGuid().ToString()[..3];
            Trailer mock = MockFactory(testTag);

            (HttpStatusCode Status, GenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<Trailer> creationResult = Framing<SuccessFrame<RecordUpdateOut<Trailer>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            Trailer creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.TrailerCommonNavigation!.Economic, creationRecord.TrailerCommonNavigation!.Economic),
            ]);
            #endregion

            #region update only main properties
            //Validate main properties changes to the previous record.
            string updatedTag = "UPDTE";
            string modifiedEco = updatedTag + "ECO" + RandomUtils.String(8);

            mock = creationRecord;

            Plate plate = mock.Plates.First();
            plate.Identifier = "identfy" + updatedTag;
            mock.TrailerCommonNavigation!.Economic = modifiedEco;
            (HttpStatusCode Status, GenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<Trailer> updateResult = Framing<SuccessFrame<RecordUpdateOut<Trailer>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            Trailer updateRecord = updateResult.Updated;
            Trailer previousRecord = updateResult.Previous;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.Model, updateRecord.Model),
                () => Assert.NotEqual(previousRecord.Plates.First().Identifier, updateRecord.Plates.First().Identifier),
                () => Assert.NotEqual(previousRecord.TrailerCommonNavigation!.Economic, updateRecord.TrailerCommonNavigation!.Economic),
            ]);
            #endregion
        }
        #endregion
    }
}