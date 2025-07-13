using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Quality.Q_Depots.Bases;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Trailers_Commons : BQ_CommonDepot<Trailer_Common, Trailer, TrailerExternal, TrailersDepot> {

    protected override Trailer_Common EntityFactory(string Entropy) {

        Status statusTRL = Store(
               new Status {
                   Name = Entropy,
                   Description =  Entropy,
                   Reference = Entropy[..8]

               }
           );

        Trailer_Common common = new Trailer_Common {
            Economic = Entropy,
            Status = statusTRL,
        };

        return common;
    }

    protected override TrailerExternal ExternalFactory(string Entropy) {

        TrailerExternal trailerExternal = new TrailerExternal {
            Carrier = Entropy,
            MxPlate = Entropy[..7],
        };

        return trailerExternal;
    }

    protected override Trailer InternalFactory(string Entropy) {

        Status statusI = Store(
               new Status {
                   Name = 'I' + Entropy,
                   Description = Entropy,
                   Reference = "I" + Entropy[..7],
               }
           );

        Carrier carrier = Store(
               new Carrier() {
                   Name = Entropy,
                   Status = statusI,
                   Approach = Store(
                            new Approach() {
                                EMail = Entropy,
                                Status = Store(
                                        new Status() {
                                            Reference = "A" + Entropy[..7],
                                            Name = "A" + Entropy,
                                        }
                                    ),
                            }
                        ),
                   Address = Store(
                            new Address() {
                                Country = Entropy[..3],
                            }
                        ),
               }
          );

        Trailer trailer = new Trailer {
            Carrier = carrier,
            Plates = [
                   Store(
                            new Plate() {
                                Identifier = Entropy[..12],
                                Country = Entropy[..3],
                                Status = Store(
                                        new Status() {
                                            Reference = "Pl" + Entropy[..6],
                                            Name = "PL" + Entropy,
                                        }
                                    )
                            }
                        ),
                    Store(
                            new Plate() {
                                Identifier = "B" + Entropy[..11],
                                Country = Entropy[..3],
                                Status = Store(
                                        new Status() {
                                            Reference = "B" + Entropy[..7],
                                            Name = "B" + Entropy,
                                        }
                                    )
                            }
                        ),
                ],
        };
       

        return trailer;
    }
}
