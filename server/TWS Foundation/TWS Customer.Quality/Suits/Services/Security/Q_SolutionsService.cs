using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Customer.Services.Security.Solutions;

using TWS_Security;
using TWS_Security.Depots.Solutions;
using TWS_Security.Sets;

namespace TWS_Customer.Quality.Suits.Services.Security;

/// <summary>
///     Quality Suit implementation for <see cref="Solutions"/>
/// </summary>
public class Q_SolutionsService
    : BQ_Service<Solution, SolutionsService, TWSSecurityDatabase> {

    public Q_SolutionsService()
        : base(new(new SolutionsDepot())) {

    }

    protected override Solution ComposeSample(string Entropy) {
        return new Solution {
            Name = Entropy,
            Description = $" Testing Record {Entropy}",
            Sign = Entropy[..5]
        };
    }

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        SetViewOptions<Solution> options = new() {
            Page = 1,
            Range = 10,
            Retroactive = false,
            Creation = DateTime.Now,
            Export = false,
        };

        ComposeSamples(10, true);

        SetViewOut<Solution> viewOut = await Service.View(options);

        Assert.True(viewOut.Count >= 10);
        Assert.Equal(10, viewOut.Length);
    }

    [Fact(DisplayName = "[Create]: Correctly creates a new Solution")]
    public async Task Create() {

        Solution sample = ComposeSamples(1)[0];
        Disposer.Push(sample);

        SetBatchOut<Solution> batchOut = await Service.Create([sample]);

        Assert.Empty(batchOut.Failures);
        Assert.NotEmpty(batchOut.Successes);

        Solution record = batchOut.Successes[0];
        Assert.True(batchOut.Successes[0].Id > 0);
        Assert.Equal(sample.Name, record.Name);
        Assert.Equal(sample.Sign, record.Sign);
        Assert.Equal(sample.Description, record.Description);
    }

    [Fact(DisplayName = "[Update]: Correctly updates a Solution")]
    public async Task Update() {
        Solution reference = ComposeSamples(1, true)[0];
        Solution sample = ComposeSamples(1)[0];
        sample.Id = reference.Id;

        RecordUpdateOut<Solution> updateOut = await Service.Update(sample);

        Solution? previous = updateOut.Previous;
        Solution updated = updateOut.Updated;

        Assert.Equal(reference.Id, previous?.Id);
        Assert.Equal(reference.Name, previous?.Name);
        Assert.Equal(reference.Sign, previous?.Sign);
        Assert.Equal(reference.Description, previous?.Description);

        Assert.Equal(sample.Id, updated.Id);
        Assert.Equal(sample.Name, updated.Name);
        Assert.Equal(sample.Sign, updated.Sign);
        Assert.Equal(sample.Description, updated.Description);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes a Solution")]
    public async Task Delete() {
        Solution sample = ComposeSamples(1)[0];
        await Service.Create([sample]);

        Solution deleted = await Service.Delete(sample.Id);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
        Assert.Equal(sample.Sign, deleted.Sign);
        Assert.Equal(sample.Description, deleted.Description);
    }
}
