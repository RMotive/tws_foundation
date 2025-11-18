using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trucks;
using TWS_Business.Quality.Q_Depots.Bases;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Trucks : BQ_CommonDepot<Truck_Common, Truck, TruckExternal, TrucksDepot> {
    protected override IQueryable<Truck_Common> CustomQueryProcessor(IQueryable<Truck_Common> sourceQuery) {
        sourceQuery = sourceQuery
         .Include(e => e.Situation)
         .Include(e => e.Location)
         .Include(e => e.Internal).ThenInclude(e => e!.Carrier).ThenInclude(e => e!.USDOT)
         .Include(e => e.Internal).ThenInclude(e => e!.SCT)
         .Include(e => e.Internal).ThenInclude(e => e!.Maintenance)
         .Include(e => e.Internal).ThenInclude(e => e!.Model)
         .Include(e => e.Internal).ThenInclude(e => e!.Insurance).ThenInclude(e => e!.Status);



        return sourceQuery;
    }

    protected override Truck_Common EntityFactory(string Entropy) {

        Status status = Store(
                new Status {
                    Name = Entropy,
                    Description = Entropy,
                    Reference = Entropy[..8],
                }
            );


        Truck_Common common = new() {
            Economic = Entropy,
            Status = status,
        };

        return common;
    }

    protected override TruckExternal ExternalFactory(string Entropy) {
        return new TruckExternal() {
            Carrier = Entropy,
        };
    }

    protected override Truck InternalFactory(string Entropy) {

        Status statusI = Store(
                new Status {
                    Name = 'I' + Entropy,
                    Description = Entropy,
                    Reference = "I" + Entropy[..7],
                }
            );

        return new Truck() {
            VIN = Entropy,
            Insurance = Store(
                    new Insurance() {
                        Policy = Entropy[..6],
                        Country = Entropy[..3],
                        Status = Store(
                                new Status() {
                                    Reference = "Ins" + Entropy[..5],
                                    Name = "Ins" + Entropy,
                                }
                            ),
                    }
                ),
            Carrier = Store(
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
                   ),
            Model = Store(
                       new VehiculeModel() {
                           Name = Entropy,
                           Status = Store(
                                   new Status() {
                                       Reference = "VM" + Entropy[..6],
                                       Name = "VM" + Entropy,
                                   }
                               ),
                           Manufacturer = Store(
                                   new Manufacturer() {
                                       Name = Entropy,
                                   }
                               ),
                       }
                   ),
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
                ],
        };
    }
}
