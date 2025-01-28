

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class AddressesService : IAddressesService {
    private readonly AddressesDepot AddressDepot;

    public AddressesService(AddressesDepot AddressDepot) {
        this.AddressDepot = AddressDepot;
    }

    public async Task<SetViewOut<Address>> View(SetViewOptions<Address> Options) {
        static IQueryable<Address> include(IQueryable<Address> query) {
            return query
                .Select(p => new Address() {
                    Id = p.Id,
                    Timestamp = p.Timestamp,
                    State = p.State,
                    Street = p.Street,
                    AltStreet = p.AltStreet,
                    City = p.City,
                    Zip = p.Zip,
                    Country = p.Country,
                    Colonia = p.Colonia,
                });

        }
        return await AddressDepot.View(Options, include);
    }
}
