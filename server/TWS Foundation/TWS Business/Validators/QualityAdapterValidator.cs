using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Quality.Q_Depots.Q_Validators;

/// <summary>
/// Defines a base attribute for creating adapters between internal and external representations of common entities.
/// </summary>
/// <typeparam name="TCommon"></typeparam>
/// <typeparam name="TInternal"></typeparam>
/// <typeparam name="TExternal"></typeparam>
[AttributeUsage(AttributeTargets.Property)]
public abstract class BAdapterAttribute<TCommon, TInternal, TExternal>
    : Attribute
    where TCommon : CommonEntity<TInternal, TExternal>
    where TInternal : CommonEntityEdge<TCommon>
    where TExternal : CommonEntityEdge<TCommon> {

    public abstract TCommon CreateInternal(string entropy);

    public abstract TCommon CreateExternal(string entropy);
}

#region Driver_Common Adapter Validator

[AttributeUsage(AttributeTargets.Property)]
public class QualityDriverAdapterAttribute
    : BAdapterAttribute<Driver_Common, Driver, DriverExternal> {

    public override Driver_Common CreateInternal(string entropy) {
        DateOnly date = new(2030, 11, 11);

        Situation situation =
               new Situation {
                   Name = "DRV" + entropy,
                   Description = entropy,
                   Reference = "DRV" + entropy[..5]
               };

        Status statusD =
                new Status {
                    Name = "D" + entropy,
                    Description = "D" + entropy,
                    Reference = "D" + entropy[..7]
                };

        Status statusID =
                new Status {
                    Name = "ID" + entropy,
                    Description = "ID" + entropy,
                    Reference = "ID" + entropy[..6]
                };

        Status statusEMP =
                new Status {
                    Name = "EMP" + entropy,
                    Description = "EMP" + entropy,
                    Reference = "EMP" + entropy[..5]
                };

        Identification identification =
                 new Identification {
                     Name = entropy,
                     LastName = entropy,
                     Status = statusID,
                 };

        Employee_Dates employee_Dates =
               new Employee_Dates {
                   CNAP = date,
                   IMSS = date,
                   Hire = date,
                   Termination = date,
               };

        Employee employee =
                new Employee {
                    CURP = entropy + entropy[..2],
                    RFC = entropy[..13],
                    NSS = entropy[..11],
                    Status = statusEMP,
                    Identification = identification,
                    Dates = employee_Dates,
                };

        Driver driver =
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
                };

        Driver_Common driverCommon =
                new Driver_Common {
                    License = entropy[..12],
                    Situation = situation,
                    Status = statusD,
                    Internal = driver,
                };

        return driverCommon;
    }

    public override Driver_Common CreateExternal(string entropy) {
        Situation situation =
              new Situation {
                  Name = "DRV" + entropy,
                  Description = entropy,
                  Reference = entropy[..8]
              };

        Status statusD =
                new Status {
                    Name = "D" + entropy,
                    Description = "D" + entropy,
                    Reference = "D" + entropy[..7]
                };

        Status statusID =
                new Status {
                    Name = "ID" + entropy,
                    Description = "ID" + entropy,
                    Reference = "ID" + entropy[..6]
                };

        Identification identification =
                new Identification {
                    Name = entropy,
                    LastName = entropy,
                    Status = statusID,
                };

        DriverExternal driverExternal =
                new DriverExternal {
                    Identification = identification,
                };

        Driver_Common driverCommon =
              new Driver_Common {
                  License = entropy[..12],
                  Situation = situation,
                  Status = statusD,
                  External = driverExternal
              };

        return driverCommon;
    }
}

#endregion

#region Truck_Common Adapter Validator
[AttributeUsage(AttributeTargets.Property)]
public class QualityTruckAdapterAttribute
    : BAdapterAttribute<Truck_Common, Truck, TruckExternal> {

    public override Truck_Common CreateInternal(string entropy) {
        Status statusTRL =
              new Status {
                  Name = "TRL" + entropy,
                  Description = "TRL" + entropy,
                  Reference = "TRL" + entropy[..5]

              };

        Status statusI =
              new Status {
                  Name = 'I' + entropy,
                  Description = entropy,
                  Reference = "I" + entropy[..7],
              };

        Carrier carrier =
                new Carrier() {
                    Name = entropy,
                    Status = statusI,
                    Approach = new Approach() {
                        EMail = entropy,
                        Status = new Status() {
                            Reference = "A" + entropy[..7],
                            Name = "A" + entropy,
                        }
                    },
                    Address = new Address() {
                        Country = entropy[..3],
                    },
                };

        VehiculeModel model =
                new VehiculeModel {
                    Name = entropy,
                    Description = entropy,
                    Status = new Status {
                        Name = "VM" + entropy,
                        Reference = "VM" + entropy[..6],
                    },
                    Manufacturer = new Manufacturer {
                        Name = entropy,
                    }
                };

        Truck truck =
                new Truck {
                    VIN = entropy,
                    Carrier = carrier,
                    Model = model,
                };

        Truck_Common common =
                new Truck_Common {
                    Economic = entropy,
                    Status = statusTRL,
                    Internal = truck,
                };

        return common;
    }

    public override Truck_Common CreateExternal(string entropy) {

        Status status =
                new Status {
                    Name = "TRC" + entropy,
                    Description = entropy,
                    Reference = "TRC" + entropy[..5],
                };

        TruckExternal truckExternal =
                new TruckExternal {
                    Carrier = entropy,
                    UsaPlate = entropy[..7],
                    MxPlate = entropy[..7],
                };

        Truck_Common common =
                new Truck_Common {
                    Economic = entropy,
                    Status = status,
                    External = truckExternal
                };

        return common;
    }
}

#endregion

#region Trailer_Common Adapter Validator

[AttributeUsage(AttributeTargets.Property)]
public class QualityTrailerAdapterAttribute
    : BAdapterAttribute<Trailer_Common, Trailer, TrailerExternal> {

    public override Trailer_Common CreateInternal(string entropy) {
        Status statusTRL =
              new Status {
                  Name = "INT" + entropy,
                  Reference = "INT" + entropy[..5]
              };

        Status statusE =
              new Status {
                  Name = 'E' + entropy,
                  Description = entropy,
                  Reference = "E" + entropy[..7],
              };

        Carrier carrier =
                new Carrier() {
                    Name = "IN" + entropy,
                    Status = statusE,
                    Approach = new Approach() {
                        EMail = entropy,
                        Status = new Status() {
                            Reference = "IN" + entropy[..6],
                            Name = "IN" + entropy,
                        }
                    },
                    Address = new Address() {
                        Country = entropy[..3],
                    },
                };

        Trailer trailer =
              new Trailer {
                  Carrier = carrier,
              };

        Trailer_Common common =
                new Trailer_Common {
                    Economic = entropy,
                    Status = statusTRL,
                    Internal = trailer,
                };

        return common;
    }

    public override Trailer_Common CreateExternal(string entropy) {
        Status statusTRL =
               new Status {
                   Name = "TRL" + entropy,
                   Description = "TRL" + entropy,
                   Reference = "TRL" + entropy[..5]

               };

        
        TrailerExternal trailerExternal =
                new TrailerExternal {
                    Carrier = entropy,
                    MxPlate = entropy[..7],
                };

        Trailer_Common common =
                new Trailer_Common {
                    Economic = entropy,
                    Status = statusTRL,
                    External = trailerExternal,
                };

        return common;
    }
}

#endregion