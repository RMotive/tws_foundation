using CSM_Foundation.Core.Utils;
using CSM_Foundation.Customer.Quality;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Directories;
using TWS_Business.Entities;

using TWS_Customer.Features.Business;
using TWS_Customer.Quality.Factories;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_SectionsService
    : BQ_Service<ISectionsService> {

    public Q_SectionsService()
        : base(
                [
                    DatabaseFactories.BusinessDatabaseFactory,
                ]
            ) {

    }

    #region [BQ_Service] implementations
    protected override ISectionsService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = DatabaseFactories.BusinessDatabaseFactory();

        ISectionsDepot SectionsDepot = new SectionsDepot(BussinesDatabase, Disposer);

        return new SectionsService(SectionsDepot);
    }
    #endregion

    #region Private Methods/Functions
    Section GenerateMock(string Entropy) {
        Status status = Store(
                new Status {
                    Name = Entropy,
                    Description = Entropy,
                }
            );

        Status status2 = Store(
                new Status {
                    Name = "a" + Entropy,
                    Description = "a" + Entropy,
                }
            );

        Address address = Store(
                new Address {
                    State = Entropy[..3],
                    Street = Entropy,
                    AltStreet = Entropy,
                    City = Entropy,
                    ZIP = Entropy[..5],
                    Country = Entropy[..3],
                    Subdivision = Entropy,
                }
            );

        Location location = Store(
                new Location {
                    Name = Entropy,
                    Description = Entropy,
                    Status = status2,
                    Address = address,
                }
            );

        return new Section {
            Name = Entropy,
            Capacity = 10,
            Ocupancy = 1,
            Status = status,
            Yard = location
        };
    }
    #endregion

    [Fact(DisplayName = "[View]: Records view")]
    public async Task View() {
        Store(GenerateMock(RandomUtils.String(16)));
        ViewOutput<Section> viewOutput = await _service.View(
                new QueryInput<Section, ViewInput<Section>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 10,
                        Page = 1,
                    }
                }
            );

        Assert.Multiple(
            () => Assert.True(viewOutput.Pages > 0),
            () => Assert.True(viewOutput.Length > 0),
            () => Assert.Equal(1, viewOutput.Page),
            () => Assert.Equal(viewOutput.Length, viewOutput.Entities.Length)

        );
    }

    [Fact(DisplayName = "[Create]: Generate new Records")]
    public async Task Create() {
        Section[] mocks = [
            GenerateMock(RandomUtils.String(16)),
            GenerateMock(RandomUtils.String(16)),
            GenerateMock(RandomUtils.String(16))

            ];
        BatchOperationOutput<Section> viewOutput = await _service.Create(mocks);

        Assert.Multiple(
            () => Assert.False(viewOutput.Failed),
            () => Assert.Equal(0, viewOutput.FailuresCount),
            () => Assert.Equal(3, viewOutput.Successes.Length),
            () => Assert.True(viewOutput.Successes.First().Id > 0)
        );
    }

    [Fact(DisplayName = "[Update]: Modify an existent record")]
    public async Task Update() {
        #region [Update] - Generate a new record.
        string entropy = RandomUtils.String(16);
        Section mock = GenerateMock(entropy);
        UpdateOutput<Section> updateOutput = await _service.Update(
                new UpdateInput<Section> {
                    Create = true,
                    Entity = mock,
                }
            );

        mock = updateOutput.Updated;

        Assert.Multiple(
            () => Assert.NotNull(updateOutput.Updated),
            () => Assert.True(updateOutput.Updated.Id > 0),
            () => Assert.Equal(updateOutput.Updated.Name, entropy)
        );
        #endregion

        #region [Update] - Modify record.
        string newEntropy = "UDT" + RandomUtils.String(13);
        mock.Name = newEntropy;
        mock.Status.Name = newEntropy;

        updateOutput = await _service.Update(
                new UpdateInput<Section> {
                    Create = false,
                    Entity = mock,
                }
            );

        Assert.Multiple(
            () => Assert.NotNull(updateOutput.Updated),
            () => Assert.NotNull(updateOutput.Original),
            () => Assert.True(updateOutput.Updated.Id > 0),
            () => Assert.Equal(updateOutput.Updated.Name, newEntropy),
            () => Assert.Equal(updateOutput.Original?.Name, entropy)

        );
        #endregion
    }

    [Fact(DisplayName = "[Delete]: Delete existent records")]
    public async Task Delete() {
        string entropy = RandomUtils.String(16);
        Section mock = Store(GenerateMock(entropy));
        Section viewOutput = await _service.Delete(mock.Id);

        Assert.Multiple(
            () => Assert.True(viewOutput.Id > 0),
            () => Assert.Equal(entropy, viewOutput.Name)
        );
    }
}
