

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ILocationsService {
    Task<SetViewOut<Location>> View(SetViewOptions<Location> Options);
    Task<SetBatchOut<Location>> Create(Location[] Locations);
    Task<RecordUpdateOut<Location>> Update(Location Location);
}
