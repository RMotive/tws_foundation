using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities.Vehicules;

namespace TWS_Customer.Services.Interfaces;
public interface IManufacturersService {
    Task<SetViewOut<Manufacturer>> View(SetViewOptions<Manufacturer> Options);

    Task<Manufacturer> Create(Manufacturer manufacturer);
}
