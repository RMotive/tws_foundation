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
                     Lastname = entropy,
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

    protected override Driver_Common ExternalDriverFactory(string entropy) {

        Situation situation = Store(
              new Situation {
                  Name = "DRV" + entropy,
                  Description = entropy,
                  Reference = entropy[..8]
              }
          );

        Status statusD = Store(
                new Status {
                    Name = "D" + entropy,
                    Description = "D" + entropy,
                    Reference = "D" + entropy[..7]

                }
            );

        Status statusID = Store(
                new Status {
                    Name = "ID" + entropy,
                    Description = "ID" + entropy,
                    Reference = "ID" + entropy[..6]
                }
            );

        Identification identification = Store(
                new Identification {
                    Name = entropy,
                    Lastname = entropy,
                    Status = statusID,
                }
       );

        Driver_Common driverCommon = Store(
              new Driver_Common {
                  License = entropy[..12],
                  Situation = situation,
                  Status = statusD,
              }
          );

        DriverExternal driverExternal = Store(
                new DriverExternal {
                    Identification = identification,
                    Common = driverCommon,
                }
            );

        driverCommon.External = driverExternal;
        return driverCommon;
    }

    protected override Trailer_Common ExternalTrailerFactory(string entropy) {
        Status statusTRL = Store(
               new Status {
                   Name = "TRL" + entropy,
                   Description = "TRL" + entropy,
                   Reference = "TRL" + entropy[..5]

               }
           );

        Trailer_Common common = Store(
                new Trailer_Common {
                    Economic = entropy,
                    Status = statusTRL,
                }
            );
        TrailerExternal trailerExternal = Store(
                new TrailerExternal {
                    Carrier = entropy,
                    MxPlate = entropy[..7],
                    Common = common,
                }
            );

        common.External = trailerExternal;
        return common;
    }

    protected override Truck_Common ExternalTruckFactory(string entropy) {
        Situation situationTRC = Store(
                new Situation {
                    Name = "TRC" + entropy,
                    Description = entropy,
                    Reference = "TRC" + entropy[..5],
                }
            );

        Status status = Store(
                new Status {
                    Name =  "TRC" +  entropy,
                    Description = entropy,
                    Reference = "TRC" + entropy[..5],
                }
            );


        Truck_Common common = Store(
                new Truck_Common {
                    Economic = entropy,
                    Status = status,
                    Situation = situationTRC,
                }
            );

        TruckExternal truckExternal = Store(
                new TruckExternal {
                    Carrier = entropy,
                    UsaPlate = entropy[..7],
                    MxPlate = entropy[..7],
                    Common = common,
                }
            );

        common.External = truckExternal;
        return common;
    }

    protected override Driver_Common InternalDriverFactory(string entropy) {

        DateOnly date = new(2030, 11, 11);

        Situation situation = Store(
               new Situation {
                   Name = "DRV" + entropy,
                   Description = entropy,
                   Reference = "DRV" + entropy[..5]

               }
           );

        Status statusD = Store(
                new Status {
                    Name = "D" + entropy,
                    Description = "D" + entropy,
                    Reference = "D" + entropy[..7]

                }
            );

        Status statusID = Store(
                new Status {
                    Name = "ID" + entropy,
                    Description = "ID" + entropy,
                    Reference = "ID" + entropy[..6]

                }
            );

        Status statusEMP = Store(
                new Status {
                    Name = "EMP" + entropy,
                    Description = "EMP" + entropy,
                    Reference = "EMP" + entropy[..5]

                }
            );

        Identification identification = Store(
                 new Identification {
                     Name = entropy,
                     Lastname = entropy,
                     Status = statusID,
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
                    Status = statusEMP,
                    Identification = identification,
                    Dates = employee_Dates,
                }
            );


        Driver_Common driverCommon = Store(
                new Driver_Common {
                    License = entropy[..12],
                    Situation = situation,
                    Status = statusD,
                }
            );

        Driver driver = Store(
                new Driver {
                    Fast = entropy[..12],
                    ANAM = entropy + entropy[..8],
                    VISA = entropy[..12],
                    TWIC = entropy[..12],
                    DriverType = entropy[..12],
                    LicenseExpiration = date,
                    DrugalcRegistrationDate = date,
                    PullnoticeRegistrationDate = date,
                    TwicExpiration = date,
                    VisaExpiration = date,
                    FastExpiration = date,
                    AnamExpiration = date,
                    Employee = employee,
                    Common = driverCommon,
                }
            );

        driverCommon.Internal = driver;
        return driverCommon;
    }

    protected override Trailer_Common InternalTrailerFactory(string entropy) {
        Status statusTRL = Store(
               new Status {
                   Name = "INT" + entropy,
                   Reference = "INT" + entropy[..5]
               }
           );

        Trailer_Common common = Store(
                new Trailer_Common {
                    Economic = entropy,
                    Status = statusTRL,
                }
            );

        Status statusE = Store(
               new Status {
                   Name = 'E' + entropy,
                   Description = entropy,
                   Reference = "E" + entropy[..7],
               }
           );

        Carrier carrier = Store(
                new Carrier() {
                    Name = "IN" + entropy,
                    Status = statusE,
                    Approach = Store(
                            new Approach() {
                                EMail = entropy,
                                Status = Store(
                                        new Status() {
                                            Reference = "IN" + entropy[..6],
                                            Name = "IN" + entropy,
                                        }
                                    ),
                            }
                        ),
                    Address = Store(
                            new Address() {
                                Country = entropy[..3],
                            }
                        ),
                }
            );

        Trailer trailer = Store(
                new Trailer {
                    Carrier = carrier,
                    Common = common,
                }
            );

        common.Internal = trailer;
        return common;
    }

    protected override Truck_Common InternalTruckFactory(string entropy) {

        Status statusTRL = Store(
             new Status {
                 Name = "TRL" + entropy,
                 Description = "TRL" + entropy,
                 Reference = "TRL" + entropy[..5]

             }
         );

        Truck_Common common = Store(
                new Truck_Common {
                    Economic = entropy,
                    Status = statusTRL,
                }
            );

        Status statusI = Store(
               new Status {
                   Name = 'I' + entropy,
                   Description = entropy,
                   Reference = "I" + entropy[..7],
               }
           );

        Carrier carrier = Store(
                new Carrier() {
                    Name = entropy,
                    Status = statusI,
                    Approach = Store(
                            new Approach() {
                                EMail = entropy,
                                Status = Store(
                                        new Status() {
                                            Reference = "A" + entropy[..7],
                                            Name = "A" + entropy,
                                        }
                                    ),
                            }
                        ),
                    Address = Store(
                            new Address() {
                                Country = entropy[..3],
                            }
                        ),
                }
            );

        VehiculeModel model = Store(
                new VehiculeModel {
                    Name = entropy,
                    Description = entropy,
                    Status = Store(
                            new Status {
                                Name = "VM" + entropy,
                                Reference = "VM" + entropy[..6],
                            }
                        ),
                    Manufacturer = Store(
                            new Manufacturer {
                                Name = entropy,
                            }
                        )
                }
            );

        Truck truck = Store(
                new Truck {
                    VIN = entropy,
                    Carrier = carrier,
                    Common = common,
                    Model = model,
                }
            );

        common.Internal = truck;
        return common;
    }
}
