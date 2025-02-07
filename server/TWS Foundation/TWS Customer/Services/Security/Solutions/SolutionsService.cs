using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Security.Depots.Solutions;
using TWS_Security.Sets;

namespace TWS_Customer.Services.Security.Solutions;
/// <summary>
///     Service implementation for <see cref="Solution"/> set, handling multi operations available for this entity.
/// </summary>
public class SolutionsService
    : ISolutionsService {

    /// <summary>
    ///     <see cref="Solution"/> data storage depot to perform basic generic operations.
    /// </summary>
    private readonly SolutionsDepot SolutionsDepot;

    /// <summary>
    ///     Creates a new <see cref="SolutionsService"/> instance. Service implementation for <see cref="Solution"/> set.
    /// </summary>
    /// <param name="Solutions"> 
    ///     Required Depot implementation to perform complex internal operations.
    /// </param>
    public SolutionsService(SolutionsDepot Solutions) {
        SolutionsDepot = Solutions;
    }

    public Task<SetViewOut<Solution>> View(SetViewOptions<Solution> Options)
    => SolutionsDepot.View(Options);

    public Task<SetBatchOut<Solution>> Create(Solution[] Solutions)
    => SolutionsDepot.Create(Solutions);

    public Task<RecordUpdateOut<Solution>> Update(Solution Solution)
    => SolutionsDepot.Update(Solution);

    public Task<Solution> Delete(int Id)
    => SolutionsDepot.Delete(Id);
}
