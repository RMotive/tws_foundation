using TWS_Business.Depots.Vehicles.Control;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;
using TWS_Business.Quality.Q_Depots.Bases;

namespace TWS_Business.Quality.Q_Depots;

public class Q_YardLogs : BQ_CommonDependence<YardLog, YardLogsDepot> {

    protected override YardLog ComposedEntity(YardLog entity) {
        entity.Driver!.Status = Store(entity.Driver.Status);
        entity.Driver!.Situation = Store(entity.Driver.Situation);

        entity.Truck!.Status = Store(entity.Truck.Status); 

        if (entity.Driver?.Internal != null) {
            entity.Driver.Internal.Employee.Identification.Status = Store(entity.Driver.Internal.Employee.Identification.Status);
            entity.Driver.Internal.Employee.Identification = Store(entity.Driver.Internal.Employee.Identification);
            entity.Driver.Internal.Employee.Status = Store(entity.Driver.Internal.Employee.Status);
            entity.Driver.Internal.Employee.Dates = Store(entity.Driver.Internal.Employee.Dates);
            entity.Driver.Internal.Employee = Store(entity.Driver.Internal.Employee);

            Driver internalDriver = entity.Driver.Internal;
            entity.Driver.Internal = null;
            entity.Driver = Store(entity.Driver);
            internalDriver.Common = entity.Driver;
            entity.Driver.Internal = Store(internalDriver);
        } else {
            entity.Driver!.External!.Identification.Status = Store(entity.Driver!.External!.Identification.Status);
            entity.Driver!.External!.Identification = Store(entity.Driver.External.Identification);
            DriverExternal externalDriver = entity.Driver.External;
            entity.Driver.External = null;
            entity.Driver = Store(entity.Driver);
            externalDriver.Common = entity.Driver;
            entity.Driver.External = Store(externalDriver);
        }

        if(entity.Truck?.Internal != null) {
            entity.Truck.Internal.Carrier.Address = Store(entity.Truck.Internal.Carrier.Address);
            entity.Truck.Internal.Carrier.Approach.Status = Store(entity.Truck.Internal.Carrier.Approach.Status);
            entity.Truck.Internal.Carrier.Approach = Store(entity.Truck.Internal.Carrier.Approach);
            entity.Truck.Internal.Carrier.Status = Store(entity.Truck.Internal.Carrier.Status);
            entity.Truck.Internal.Carrier = Store(entity.Truck.Internal.Carrier);
            entity.Truck.Internal.Model.Status = Store(entity.Truck.Internal.Model.Status);
            entity.Truck.Internal.Model.Manufacturer = Store(entity.Truck.Internal.Model.Manufacturer);
            entity.Truck.Internal.Model = Store(entity.Truck.Internal.Model);

            Truck internalTruck = entity.Truck.Internal;
            entity.Truck.Internal = null;
            entity.Truck = Store(entity.Truck);
            internalTruck.Common = entity.Truck;
            entity.Truck.Internal = Store(internalTruck);

        }else {
            TruckExternal externalTruck = entity.Truck!.External!;
            entity.Truck.External = null;
            entity.Truck = Store(entity.Truck);
            externalTruck.Common = entity.Truck;
            entity.Truck.External = Store(externalTruck);
        }

        if (entity.Trailer != null) { 
            entity.Trailer.Status = Store(entity.Trailer.Status);
            if (entity.Trailer.Internal != null) {
                entity.Trailer.Internal.Carrier.Address = Store(entity.Trailer.Internal.Carrier.Address);
                entity.Trailer.Internal.Carrier.Approach.Status = Store(entity.Trailer.Internal.Carrier.Approach.Status);
                entity.Trailer.Internal.Carrier.Approach = Store(entity.Trailer.Internal.Carrier.Approach);
                entity.Trailer.Internal.Carrier.Status = Store(entity.Trailer.Internal.Carrier.Status);
                entity.Trailer.Internal.Carrier = Store(entity.Trailer.Internal.Carrier);

                Trailer internalTrailer = entity.Trailer.Internal;
                entity.Trailer.Internal = null;
                entity.Trailer = Store(entity.Trailer);
                internalTrailer.Common = entity.Trailer;
                entity.Trailer.Internal = Store(internalTrailer);
            } else {
                TrailerExternal externalTrailer = entity.Trailer!.External!;
                entity.Trailer.External = null;
                entity.Trailer = Store(entity.Trailer);
                externalTrailer.Common = entity.Trailer;
                entity.Trailer.External = Store(externalTrailer);
            }
            
        }


        return entity;
    }

    protected override YardLog EntityFactory(string entropy) {
        DateOnly date = new(2030, 11, 11);

        Status status = Store(
                new Status {
                    Name = entropy,
                    Description = entropy,
                    Reference = entropy[..8]
                }
            );

        Status statusEmp = Store(
                new Status {
                    Name = "COM" + entropy,
                    Description = entropy,
                    Reference = "COM" + entropy[..5]

                }
            );

        Identification identification = Store(
                 new Identification {
                     Name = entropy,
                     LastName = entropy,
                     Status = status,
                 }
        );

        Employee_Dates employee_Dates = Store(
               new Employee_Dates {
                   CNAP = date,
                   IMSS = date,
                   Hire = date,
                   Termination = date,
               }
           );

        Employee employee = Store(
                new Employee {
                    CURP = entropy + entropy[..2],
                    RFC = entropy[..13],
                    NSS = entropy[..11],
                    Status = statusEmp,
                    Identification = identification,
                    Dates = employee_Dates,
                }
            );

        LoadType loadtype = Store(
                new LoadType {
                    Name = entropy,
                    Description = entropy,
                    Reference = entropy[..8]

                }
            );

        Section section = Store(
                new Section {
                    Name = entropy,
                    Capacity = 10,
                    Ocupancy = 1,
                    Status = Store(
                            new Status {
                                Name = "SEC" + entropy,
                                Description = entropy,
                                Reference = "SEC" + entropy[..5]

                            }

                        ),
                    Yard = Store(
                            new Location {
                                Name = entropy,
                                Description = entropy,
                                Status = Store(
                                        new Status {
                                            Name = "Y" + entropy,
                                            Reference = "Y" + entropy[..7]

                                        }
                                    ),
                                Address = Store(
                                         new Address {
                                             State = entropy[..3],
                                             Street = entropy,
                                             AltStreet = entropy,
                                             City = entropy,
                                             ZIP = entropy[..5],
                                             Country = entropy[..3],
                                             Subdivision = entropy,
                                         }
                                    )
                            }
                        )
                }
            );

        return new YardLog {
            Entry = true,
            Seal = entropy,
            FromTo = entropy,
            Evidence = [],
            LoadType = loadtype,
            Guard = employee,
            Section = section,
        };
    }
}
