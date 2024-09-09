using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IYardLogsService {
    Task<SetViewOut<YardLog>> View(SetViewOptions<YardLog> options);
    Task<SetComplexOut<YardLog>> Create(YardLog[] trucks);
    Task<RecordUpdateOut<YardLog>> Update(YardLog YardLog, bool updatePivot);
    Task<YardLog> Delete(int Id);

}
