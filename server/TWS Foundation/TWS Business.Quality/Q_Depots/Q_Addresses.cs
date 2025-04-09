using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Addresses : BQ_Business<Address, AddressesDepot>  {
   
    protected override Address EntityFactory(string Entropy) {

        return new Address {
            State = Entropy[..3],
            Street = Entropy,
            AltStreet = Entropy,
            City = Entropy,
            ZIP = Entropy[..5],
            Country = Entropy[..3],
            Subdivision = Entropy,
        };
    }
}
