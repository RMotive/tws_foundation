using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities.Carriers;

namespace TWS_Customer.Services.Interfaces;
public interface ICarriersService {
    Task<SetViewOut<Carrier>> View(SetViewOptions<Carrier> Options);

    Task<Carrier> Create(Carrier manufacturer);
}
