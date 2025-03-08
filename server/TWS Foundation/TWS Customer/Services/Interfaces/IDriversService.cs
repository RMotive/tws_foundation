using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities.Drivers;

namespace TWS_Customer.Services.Interfaces;
public interface IDriversService {
    Task<SetViewOut<Driver>> View(SetViewOptions<Driver> Options);
}
