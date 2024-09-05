
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class PlatesServices
    : IPlatesService {
    private readonly PlatesDepot Plates;

    public PlatesServices(PlatesDepot plates) {
        Plates = plates;
    }

    public async Task<SetViewOut<Plate>> View(SetViewOptions options) {
        return await Plates.View(options, query => query
            .Select(p => new Plate() {
                Id = p.Id,
                Identifier = p.Identifier,
                State = p.State,
                Country = p.Country,
                Expiration = p.Expiration,
                Truck = p.Truck,
            }));
    }

    public async Task<Plate> Create(Plate plate) {
        return await Plates.Create(plate);
    }
}
