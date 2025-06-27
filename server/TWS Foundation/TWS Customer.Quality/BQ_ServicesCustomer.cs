using System.Text;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Customer.Quality;
using CSM_Foundation.Database.Utilitites;

using CSM_Security.Entities;

using TWS_Business.Entities;
using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Customer.Quality;
public abstract class BQ_ServicesCustomer<TService>
    : BQ_Service<TService> {

    /// <summary>
    /// 
    /// </summary>
    protected string Entropy => RandomUtils.String(16);

    public BQ_ServicesCustomer()
        : base(
                [
                    SecurityDatabaseFactory,
                    BusinessDatabaseFactory,
                ]
            ) {
    }

    #region Database Factories

    protected static CSM_Security.Database SecurityDatabaseFactory() {
        return DatabaseUtilities.Q_Construct<CSM_Security.Database>(CSM_Security.Database.SIGN);
    }

    protected static TWS_Business.Database BusinessDatabaseFactory() {
        return DatabaseUtilities.Q_Construct<TWS_Business.Database>(TWS_Business.Database.SIGN);
    }

    #endregion

    #region Entities Factories

    protected Truck_Common SampleTruckCommon(bool internalValue) { 
        Truck_Common common = Store(
                new Truck_Common {
                    Economic = Entropy[..16],
                    Status = SampleStatus("tcm"),
                    Situation = SampleSituation(),
                }
            );
        if (internalValue) {
            Truck truck = SampleTruck(false);
            truck.Common = common;
            truck = Store(truck);
            common.Internal = truck;
        } else {
            TruckExternal external = SampleTruckExternal(false);
            external.Common = common;
            external = Store(external);
            common.External = external;
        }
        return common;

    }

    protected TruckExternal SampleTruckExternal(bool saveEntity = true) {
        TruckExternal external = new TruckExternal {
            Carrier = Entropy[..10],
        };
        if (saveEntity) return Store(external);
        return external;
    }

    protected Truck SampleTruck(bool saveEntity = true) {
        Truck truck = new() {
            VIN = Entropy[..10],
            Model = SampleVehiculeModel(),
            Carrier = SampleCarrier(),
            Plates = [
                        SamplePlate("pl1"),
                        SamplePlate("pl2")
                    ],
        };
        if (saveEntity) return Store(truck);
        return truck;
    }

    protected Plate SamplePlate(string prefix) {
        return Store(
                new Plate {
                    Identifier = Entropy[..10],
                    Status = SampleStatus(prefix),
                    Country = Entropy[..3],
                }
            );
    }

    protected Situation SampleSituation() {
        return Store(
                new Situation {
                    Name = Entropy[..10],
                    Reference = Entropy[..8],
                }
            );
    }

    protected LoadType SampleLoadtype() {
        return Store(
                new LoadType {
                    Name = Entropy[..10],
                    Reference = Entropy[..8],
                }
            );
    }

    protected VehiculeModel SampleVehiculeModel() {
        return Store(
                new VehiculeModel {
                    Name = Entropy[..10],
                    Year = DateOnly.FromDateTime(DateTime.Now),
                    Status = SampleStatus("vmo"),
                    Manufacturer = SampleManufacturer(),
                }
            );
    }

    protected Manufacturer SampleManufacturer() {
        return Store(
          new Manufacturer {
              Name = Entropy[..10],
          }
        );
    }

    protected Carrier SampleCarrier() {
        Approach approach = Store(
                 new Approach {
                     EMail = $" email_{Entropy}",
                     Status = SampleStatus("apc")
                 }
             );

        return Store(
                new Carrier {
                    Name = $"carrier_{Entropy}",
                    Status = SampleStatus("car"),
                    Address = SampleAddress(),
                    Approach = approach,
                }
            );
    }

    protected Trailer_Type SampleTrailerType() {
        return Store(
                 new Trailer_Type {
                     Size = Entropy[..5],
                     Status = SampleStatus("ttp"),
                     Class = SampleTrailerClass()
                 }
            );
    }

    protected Trailer_Class SampleTrailerClass() {
        return Store(
                 new Trailer_Class {
                     Name = Entropy[..10],
                 }
            );
    }


    protected Section SampleSection() {
        return Store(
                 new Section {
                     Name = Entropy,
                     Capacity = 10,
                     Ocupancy = 1,
                     Status = SampleStatus("sec"),
                     Yard = SampleLocation()
                 }
            );
    }

    /// <summary>
    /// Status entity factory. 
    /// </summary>
    /// <param name="prefix">
    /// Sample prefix to prevent duplicate values in database.
    /// Must be 3 characters.
    /// </param>
    /// <returns></returns>
    protected Status SampleStatus(string prefix) {
        return Store(
                new Status {
                    Name = prefix + "_" + Entropy,
                    Description = "_desc" + prefix + Entropy,
                    Reference = prefix + Entropy[..5],
                }
            );
    }

    protected Location SampleLocation() {
        return Store(
                 new Location {
                     Name = Entropy,
                     Status = SampleStatus("loc"),
                     Address = SampleAddress()
                 }
            );
    }

    protected Employee SampleEmployee() {
        DateOnly date = new(2030, 11, 11);

        Identification identification = Store(
                 new Identification {
                     Name = $"ident_employee_{Entropy}",
                     LastName = Entropy,
                     Status = SampleStatus("ide"),
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

        return Store(
                new Employee {
                    CURP = Entropy + Entropy[..2],
                    RFC = Entropy[..13],
                    NSS = Entropy[..11],
                    Status = SampleStatus("emp"),
                    Identification = identification,
                    Dates = employee_Dates,
                }
            );
    }

    protected Address SampleAddress() {
        return Store(
                new Address {
                    State = Entropy[..3],
                    Street = $"{Entropy}_Street",
                    AltStreet = $"{Entropy}_altStreet",
                    City = $"{Entropy}_city",
                    ZIP = Entropy[..5],
                    Country = Entropy[..3],
                    Subdivision = $"{Entropy}_subdivision",
                }
            );
    }

    /// <summary>
    ///     
    /// </summary>
    /// <returns></returns>
    protected Contact SampleContact() {
        return Store(
                new Contact {
                    Name = $"{Entropy}_name",
                    Lastname = $"{Entropy}_lastname",
                    Phone = Entropy[..10],
                    EMail = $"{Entropy}@csm.com"
                }
            );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="contact"></param>
    /// <returns></returns>
    protected Account SampleAccount(Contact? contact = null, Permit[]? permits = null, Profile[]? profiles = null) {
        Contact contactSample = contact ?? SampleContact();
        Permit[] permitSamples = permits ?? [];
        Profile[] profilesSamples = profiles ?? [];

        return Store(
                new Account {
                    User = $"{Entropy}_usr",
                    Password = Encoding.UTF8.GetBytes($"{Entropy}_pwd"),
                    Contact = contactSample,
                    Permits = permitSamples,
                    Profiles = profilesSamples,
                }
            );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="enabled"></param>
    /// <returns></returns>
    protected CSM_Security.Entities.Action SampleAction(bool enabled = true) {
        return Store(
                new CSM_Security.Entities.Action {
                    Name = $"Action_{Entropy}",
                    Description = $"$Action_{Entropy}_Description",
                    Enabled = enabled,
                }
            );
    }


    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    protected Solution SampleSolution() {
        return Store(
                new Solution {
                    Name = $"Solution_{Entropy}",
                    Sign = Entropy[..5],
                    Description = $"Solution_{Entropy}_Description",
                }
            );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="enabled"></param>
    /// <returns></returns>
    protected Feature SampleFeature(bool enabled = true) {
        return Store(
                new Feature {
                    Name = $"Feature_{Entropy}",
                    Description = $"Feature_{Entropy}_Description",
                    Enabled = enabled,
                }
            );
    }


    /// <summary>
    /// 
    /// </summary>
    /// <param name="feature"></param>
    /// <param name="solution"></param>
    /// <param name="action"></param>
    /// <param name="enabled"></param>
    /// <returns></returns>
    protected Permit SamplePermit(Feature? feature = null, Solution? solution = null, CSM_Security.Entities.Action? action = null, bool enabled = true) {

        CSM_Security.Entities.Action actionSample = action ?? SampleAction();
        Solution solutionSample = solution ?? SampleSolution();
        Feature featureSample = feature ?? SampleFeature();

        return Store(
                new Permit {
                    Reference = Entropy[..8],
                    Enabled = enabled,
                    Action = actionSample,
                    Feature = featureSample,
                    Solution = solutionSample,
                }
            );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="permits"></param>
    /// <returns></returns>
    protected Profile SampleProfile(Permit[]? permits = null) {
        Permit[] samplePermits = permits ?? [];

        return Store(
                new Profile {
                    Name = $"Profile_{Entropy}",
                    Description = $"Profile_{Entropy}_Description",
                    Permits = samplePermits,
                }
            );
    }

    #endregion
}
