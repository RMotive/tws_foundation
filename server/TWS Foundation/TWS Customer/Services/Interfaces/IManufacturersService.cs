using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IManufacturersService {
    Task<SetViewOut<Manufacturer>> View(SetViewOptions<Manufacturer> Options);

    Task<Manufacturer> Create(Manufacturer manufacturer);
}
