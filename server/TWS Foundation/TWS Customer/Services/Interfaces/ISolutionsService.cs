using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using TWS_Security.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ISolutionsService {
    Task<SetViewOut<Solution>> View(SetViewOptions Options);
    Task<SourceTransactionOut<Solution>> Create(Solution[] Solutions);
    Task<RecordUpdateOut<Solution>> Update(Solution Solution);
}
