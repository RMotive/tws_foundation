using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Security.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ISolutionsService {
    Task<SetViewOut<Solution>> View(SetViewOptions<Solution> Options);
    Task<SetComplexOut<Solution>> Create(Solution[] Solutions);
    Task<RecordUpdateOut<Solution>> Update(Solution Solution);

    Task<Solution> Delete(int Id);
}
