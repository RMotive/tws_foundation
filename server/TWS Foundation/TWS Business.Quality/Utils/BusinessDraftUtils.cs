using CSM_Foundation.Core.Utils;

using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Quality.Utils;


/// <summary>
///     Handles { <see cref="Database"/> } objects drafting for quality tests purposes.
/// </summary>
public static class BusinessDraftUtils {

    /// <summary>
    ///     Gets a new random 16 length string.
    /// </summary>
    static string Entropy => RandomUtils.String(16);

    public static YardLog SampleYardlog() {
        return new YardLog {
            Entry = true,
            FromTo = Entropy,
            Reservation = false,
            Seal = Entropy[..10],
            LoadType = SampleLoadtype(),
            Guard = SampleEmployee(),
            Section = SampleSection(),
            Truck = SampleTruckCommon(true),
            Trailer = SampleTrailerCommon(true),
            Driver = SampleDriverCommon(true),
        };
    }


    public static Driver_Common SampleDriverCommon(bool internalValue) {
        Driver_Common common = new() {
            License = Entropy[..8],
            Status = SampleStatus("dcm"),
            Situation = SampleSituation(),
            Internal = internalValue ? SampleDriver() : null,
            External = internalValue ? null : SampleDriverExternal(),
        };

        return common;
    }

    public static Identification SampleIdentification(string prefix) {
        return new Identification {
            Name = prefix + Entropy[..10],
            LastName = Entropy[..10],
            Status = SampleStatus(prefix),
        };
    }

    public static DriverExternal SampleDriverExternal() {
        DriverExternal driverExternal = new() {
            Identification = SampleIdentification("dve"),
        };
        return driverExternal;
    }

    public static Driver SampleDriver() {
        Driver driver = new() {
            Fast = Entropy[..12],
            Employee = SampleEmployee(),
        };
        return driver;
    }

    public static Trailer_Common SampleTrailerCommon(bool internalValue) {
        Trailer_Common common = new Trailer_Common {
            Economic = Entropy[..12],
            Status = SampleStatus("tcm"),
            Situation = SampleSituation(),
            Internal = internalValue ? SampleTrailer() : null,
            External = internalValue ? null : SampleTrailerExternal()
        };

        return common;
    }

    public static TrailerExternal SampleTrailerExternal() {
        TrailerExternal trailerExternal = new() {
            Carrier = Entropy[..10],
        };

        return trailerExternal;
    }

    public static Trailer SampleTrailer() {
        Trailer trailer = new() {
            Carrier = SampleCarrier(),
            Plates = [
                    SamplePlate("pl1"),
                    SamplePlate("pl2")
                ],
        };

        return trailer;
    }

    public static Truck_Common SampleTruckCommon(bool internalValue) {
        Truck_Common common = new Truck_Common {
            Economic = Entropy[..12],
            Status = SampleStatus("tcm"),
            Situation = SampleSituation(),
            Internal = internalValue ? SampleTruck() : null,
            External = internalValue ? null : SampleTruckExternal()
        };

        return common;
    }

    public static TruckExternal SampleTruckExternal() {
        TruckExternal external = new() {
            Carrier = Entropy[..10],
        };
        return external;
    }

    public static Truck SampleTruck() {
        Truck truck = new() {
            VIN = Entropy[..10],
            Model = SampleVehiculeModel(),
            Carrier = SampleCarrier(),
            Plates = [
                        SamplePlate("pl1"),
                        SamplePlate("pl2")
                    ],
        };
        return truck;
    }

    public static Plate SamplePlate(string prefix) {
        return new Plate {
            Identifier = Entropy[..10],
            Status = SampleStatus(prefix),
            Country = Entropy[..3],
        };
    }

    public static Situation SampleSituation() {
        Situation situation = new() {
            Name = Entropy[..10],
            Reference = Entropy[..8],
        };

        return situation;
    }

    public static LoadType SampleLoadtype() {
        return new LoadType {
            Name = Entropy[..10],
            Reference = Entropy[..8],
        };
    }

    public static VehiculeModel SampleVehiculeModel() {
        return new VehiculeModel {
            Name = Entropy[..10],
            Year = DateOnly.FromDateTime(DateTime.Now),
            Status = SampleStatus("vmo"),
            Manufacturer = SampleManufacturer(),
        };
    }

    public static Manufacturer SampleManufacturer() {
        return new Manufacturer {
            Name = Entropy[..10],
        };
    }

    public static Carrier SampleCarrier() {
        Approach approach = new() {
            EMail = $" email_{Entropy}",
            Status = SampleStatus("apc")
        };

        return new Carrier {
            Name = $"carrier_{Entropy}",
            Status = SampleStatus("car"),
            Address = SampleAddress(),
            Approach = approach,
        };
    }

    public static Trailer_Type SampleTrailerType() {
        return new Trailer_Type {
            Size = Entropy[..5],
            Status = SampleStatus("ttp"),
            Class = SampleTrailerClass()
        };
    }

    public static Trailer_Class SampleTrailerClass() {
        return new Trailer_Class {
            Name = Entropy[..10],
        };
    }


    public static Section SampleSection() {
        return new Section {
            Name = Entropy,
            Capacity = 10,
            Ocupancy = 1,
            Status = SampleStatus("sec"),
            Yard = SampleLocation()
        };
    }

    /// <summary>
    /// Status entity factory. 
    /// </summary>
    /// <param name="prefix">
    /// Sample prefix to prevent duplicate values in database.
    /// Must be 3 characters.
    /// </param>
    /// <returns></returns>
    public static Status SampleStatus(string prefix) {
        Status status = new() {
            Name = prefix + "_" + Entropy,
            Description = "_desc" + prefix + Entropy,
            Reference = prefix + Entropy[..5],
        };

        return status;
    }

    public static Location SampleLocation() {
        return new Location {
            Name = Entropy,
            Status = SampleStatus("loc"),
            Address = SampleAddress()
        };
    }

    public static Employee SampleEmployee() {
        DateOnly date = new(2030, 11, 11);

        Identification identification = new() {
            Name = $"ident_employee_{Entropy}",
            LastName = Entropy,
            Status = SampleStatus("ide"),
        };

        Employee_Dates employee_Dates = new Employee_Dates {
            CNAP = date,
            IMSS = date,
            Hire = date,
            Termination = date,
        };

        return new Employee {
            CURP = Entropy + Entropy[..2],
            RFC = Entropy[..13],
            NSS = Entropy[..11],
            Status = SampleStatus("emp"),
            Identification = identification,
            Dates = employee_Dates,
        };
    }

    public static Address SampleAddress() {
        return new() {
            State = Entropy[..3],
            Street = $"{Entropy}_Street",
            AltStreet = $"{Entropy}_altStreet",
            City = $"{Entropy}_city",
            ZIP = Entropy[..5],
            Country = Entropy[..3],
            Subdivision = $"{Entropy}_subdivision",
        };
    }
}