using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Sets;
using TWS_Customer.Services.Interfaces;

using Xunit.Abstractions;

namespace TWS_Customer.Services;
public class YardLogsService 
    : IYardLogsService {
    private readonly YardLogsDepot YardLogs;
    private readonly TWSBusinessDatabase Database;
    protected readonly IDisposer? Disposer;

    public YardLogsService(YardLogsDepot YardLogs, TWSBusinessDatabase Database, IDisposer? Disposer) {
        this.YardLogs = YardLogs;
        this.Database = Database;
        this.Disposer = Disposer;
    }
    private IQueryable<YardLog> Include(IQueryable<YardLog> query) {
        return query
            .Select(y => new YardLog() {
                Id = y.Id,
                Entry = y.Entry,
                Timestamp = y.Timestamp,
                Truck = y.Truck,
                TruckExternal = y.TruckExternal,
                Trailer = y.Trailer,
                TrailerExternal = y.TrailerExternal,
                LoadType = y.LoadType,
                Guard = y.Guard,
                Gname = y.Gname,
                Seal = y.Seal,
                SealAlt = y.SealAlt,
                Section = y.Section,
                FromTo = y.FromTo,
                Damage = y.Damage,
                TTPicture = y.TTPicture,
                DmgEvidence = y.DmgEvidence,
                Driver = y.Driver,
                DriverExternal = y.DriverExternal,
                DriverExternalNavigation = y.DriverExternalNavigation == null ? null : new DriverExternal() {
                    Id = y.DriverExternalNavigation.Id,
                    Timestamp = y.DriverExternalNavigation.Timestamp,
                    Status = y.DriverExternalNavigation.Status,
                    Common = y.DriverExternalNavigation.Common,
                    Identification = y.DriverExternalNavigation.Identification,
                    DriverCommonNavigation = y.DriverExternalNavigation.DriverCommonNavigation == null ? null : new DriverCommon() {
                        Id = y.DriverExternalNavigation.DriverCommonNavigation.Id,
                        Status = y.DriverExternalNavigation.DriverCommonNavigation.Status,
                        License = y.DriverExternalNavigation.DriverCommonNavigation.License,
                        Situation = y.DriverExternalNavigation.DriverCommonNavigation.Situation,
                    },
                    IdentificationNavigation = y.DriverExternalNavigation.IdentificationNavigation == null ? null : new Identification() {
                        Id = y.DriverExternalNavigation.IdentificationNavigation.Id,
                        Timestamp = y.DriverExternalNavigation.IdentificationNavigation.Timestamp,
                        Status = y.DriverExternalNavigation.IdentificationNavigation.Status,
                        Name = y.DriverExternalNavigation.IdentificationNavigation.Name,
                        FatherLastname = y.DriverExternalNavigation.IdentificationNavigation.FatherLastname,
                        MotherLastName = y.DriverExternalNavigation.IdentificationNavigation.MotherLastName,
                        Birthday = y.DriverExternalNavigation.IdentificationNavigation.Birthday
                    }
                },
                DriverNavigation = y.DriverNavigation == null ? null : new Driver() {
                    Id = y.DriverNavigation.Id,
                    Timestamp = y.DriverNavigation.Timestamp,
                    Status = y.DriverNavigation.Status,
                    Employee = y.DriverNavigation.Employee,
                    Common = y.DriverNavigation.Common,
                    DriverType = y.DriverNavigation.DriverType,
                    LicenseExpiration = y.DriverNavigation.LicenseExpiration,
                    DrugalcRegistrationDate = y.DriverNavigation.DrugalcRegistrationDate,
                    PullnoticeRegistrationDate = y.DriverNavigation.PullnoticeRegistrationDate,
                    Twic = y.DriverNavigation.Twic,
                    TwicExpiration = y.DriverNavigation.TwicExpiration,
                    Visa = y.DriverNavigation.Visa,
                    VisaExpiration = y.DriverNavigation.VisaExpiration,
                    Fast = y.DriverNavigation.Fast,
                    FastExpiration = y.DriverNavigation.FastExpiration,
                    Anam = y.DriverNavigation.Anam,
                    AnamExpiration = y.DriverNavigation.AnamExpiration,
                    EmployeeNavigation = y.DriverNavigation.EmployeeNavigation == null ? null : new Employee() {
                        Id = y.DriverNavigation.EmployeeNavigation.Id,
                        Timestamp = y.DriverNavigation.EmployeeNavigation.Timestamp,
                        Status = y.DriverNavigation.EmployeeNavigation.Status,
                        Identification = y.DriverNavigation.EmployeeNavigation.Identification,
                        Address = y.DriverNavigation.EmployeeNavigation.Address,
                        Approach = y.DriverNavigation.EmployeeNavigation.Approach,
                        Curp = y.DriverNavigation.EmployeeNavigation.Curp,
                        AntecedentesNoPenaleseExp = y.DriverNavigation.EmployeeNavigation.AntecedentesNoPenaleseExp,
                        Rfc = y.DriverNavigation.EmployeeNavigation.Rfc,
                        Nss = y.DriverNavigation.EmployeeNavigation.Nss,
                        IMSSRegistrationDate = y.DriverNavigation.EmployeeNavigation.IMSSRegistrationDate,
                        HiringDate = y.DriverNavigation.EmployeeNavigation.HiringDate,
                        TerminationDate = y.DriverNavigation.EmployeeNavigation.TerminationDate,
                        IdentificationNavigation = y.DriverNavigation.EmployeeNavigation.IdentificationNavigation == null ? null : new Identification() {
                            Id = y.DriverNavigation.EmployeeNavigation.IdentificationNavigation.Id,
                            Timestamp = y.DriverNavigation.EmployeeNavigation.IdentificationNavigation.Timestamp,
                            Status = y.DriverNavigation.EmployeeNavigation.IdentificationNavigation.Status,
                            Name = y.DriverNavigation.EmployeeNavigation.IdentificationNavigation.Name,
                            FatherLastname = y.DriverNavigation.EmployeeNavigation.IdentificationNavigation.FatherLastname,
                            MotherLastName = y.DriverNavigation.EmployeeNavigation.IdentificationNavigation.MotherLastName,
                            Birthday = y.DriverNavigation.EmployeeNavigation.IdentificationNavigation.Birthday
                        }
                    },
                    DriverCommonNavigation = y.DriverNavigation.DriverCommonNavigation == null ? null : new DriverCommon() {
                        Id = y.DriverNavigation.DriverCommonNavigation.Id,
                        Timestamp = y.DriverNavigation.DriverCommonNavigation.Timestamp,
                        Status = y.DriverNavigation.DriverCommonNavigation.Status,
                        License = y.DriverNavigation.DriverCommonNavigation.License,
                        Situation = y.DriverNavigation.DriverCommonNavigation.Situation,
                    },
                },
                TrailerExternalNavigation = y.TrailerExternalNavigation == null ? null : new TrailerExternal() {
                    Id = y.TrailerExternalNavigation.Id,
                    Timestamp = y.TrailerExternalNavigation.Timestamp,
                    Status = y.TrailerExternalNavigation.Status,
                    Common = y.TrailerExternalNavigation.Common,
                    UsaPlate = y.TrailerExternalNavigation.UsaPlate,
                    MxPlate = y.TrailerExternalNavigation.MxPlate,
                    Carrier = y.TrailerExternalNavigation.Carrier,
                    TrailerCommonNavigation = y.TrailerExternalNavigation.TrailerCommonNavigation == null ? null : new TrailerCommon() {
                        Id = y.TrailerExternalNavigation.TrailerCommonNavigation.Id,
                        Timestamp = y.TrailerExternalNavigation.TrailerCommonNavigation.Timestamp,
                        Status = y.TrailerExternalNavigation.TrailerCommonNavigation.Status,
                        Economic = y.TrailerExternalNavigation.TrailerCommonNavigation.Economic,
                        Type = y.TrailerExternalNavigation.TrailerCommonNavigation.Type,
                        Situation = y.TrailerExternalNavigation.TrailerCommonNavigation.Situation,
                        Location = y.TrailerExternalNavigation.TrailerCommonNavigation.Location,
                        TrailerTypeNavigation = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation == null? null : new TrailerType() {
                            Id = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation.Id,
                            Timestamp = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation.Timestamp,
                            Status = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation.Status,
                            Size = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation.Size,
                            TrailerClass = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClass,
                            TrailerClassNavigation = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation == null? null : new TrailerClass() {
                                Id = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Id,
                                Timestamp = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Timestamp,
                                Name = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Name,
                                Description = y.TrailerExternalNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Description
                            }
                        }
                    }
                },
                TrailerNavigation = y.TrailerNavigation == null ? null : new Trailer() {
                    Id = y.TrailerNavigation.Id,
                    Timestamp = y.TrailerNavigation.Timestamp,
                    Status = y.TrailerNavigation.Status,
                    Common = y.TrailerNavigation.Common,
                    Model = y.TrailerNavigation.Model,
                    Maintenance = y.TrailerNavigation.Maintenance,
                    Carrier = y.TrailerNavigation.Carrier,
                    SctNavigation = y.TrailerNavigation.SctNavigation,
                    VehiculeModelNavigation = y.TrailerNavigation.VehiculeModelNavigation == null ? null : new VehiculeModel() {
                        Id = y.TrailerNavigation.VehiculeModelNavigation.Id,
                        Timestamp = y.TrailerNavigation.VehiculeModelNavigation.Timestamp,
                        Status = y.TrailerNavigation.VehiculeModelNavigation.Status,
                        Name = y.TrailerNavigation.VehiculeModelNavigation.Name,
                        Year = y.TrailerNavigation.VehiculeModelNavigation.Year,
                        Manufacturer = y.TrailerNavigation.VehiculeModelNavigation.Manufacturer,
                        ManufacturerNavigation = y.TrailerNavigation.VehiculeModelNavigation.ManufacturerNavigation == null ? null : new Manufacturer() {
                            Id = y.TrailerNavigation.VehiculeModelNavigation.ManufacturerNavigation.Id,
                            Timestamp = y.TrailerNavigation.VehiculeModelNavigation.ManufacturerNavigation.Timestamp,
                            Name = y.TrailerNavigation.VehiculeModelNavigation.ManufacturerNavigation.Name,
                            Description = y.TrailerNavigation.VehiculeModelNavigation.ManufacturerNavigation.Description,
                        },
                    },
                    CarrierNavigation = y.TrailerNavigation.CarrierNavigation == null ? null : new Carrier() {
                        Id = y.TrailerNavigation.CarrierNavigation.Id,
                        Status = y.TrailerNavigation.CarrierNavigation.Status,
                        Name = y.TrailerNavigation.CarrierNavigation.Name,
                        Approach = y.TrailerNavigation.CarrierNavigation.Approach,
                        Address = y.TrailerNavigation.CarrierNavigation.Address,
                        Usdot = y.TrailerNavigation.CarrierNavigation.Usdot,
                        ApproachNavigation = y.TrailerNavigation.CarrierNavigation.ApproachNavigation == null ? null : new Approach() {
                            Id = y.TrailerNavigation.CarrierNavigation.ApproachNavigation.Id,
                            Timestamp = y.TrailerNavigation.CarrierNavigation.ApproachNavigation.Timestamp,
                            Status = y.TrailerNavigation.CarrierNavigation.ApproachNavigation.Status,
                            Enterprise = y.TrailerNavigation.CarrierNavigation.ApproachNavigation.Enterprise,
                            Personal = y.TrailerNavigation.CarrierNavigation.ApproachNavigation.Personal,
                            Alternative = y.TrailerNavigation.CarrierNavigation.ApproachNavigation.Alternative,
                            Email = y.TrailerNavigation.CarrierNavigation.ApproachNavigation.Email,
                        },
                        UsdotNavigation = y.TrailerNavigation.CarrierNavigation.UsdotNavigation == null ? null : new Usdot() {
                            Id = y.TrailerNavigation.CarrierNavigation.UsdotNavigation.Id,
                            Timestamp = y.TrailerNavigation.CarrierNavigation.UsdotNavigation.Timestamp,
                            Status = y.TrailerNavigation.CarrierNavigation.UsdotNavigation.Status,
                            Mc = y.TrailerNavigation.CarrierNavigation.UsdotNavigation.Mc,
                            Scac = y.TrailerNavigation.CarrierNavigation.UsdotNavigation.Scac,
                        },
                    },
                    TrailerCommonNavigation = y.TrailerNavigation.TrailerCommonNavigation == null ? null : new TrailerCommon() {
                        Id = y.TrailerNavigation.TrailerCommonNavigation.Id,
                        Timestamp = y.TrailerNavigation.TrailerCommonNavigation.Timestamp,
                        Status = y.TrailerNavigation.TrailerCommonNavigation.Status,
                        Economic = y.TrailerNavigation.TrailerCommonNavigation.Economic,
                        Type = y.TrailerNavigation.TrailerCommonNavigation.Type,
                        Situation = y.TrailerNavigation.TrailerCommonNavigation.Situation,
                        Location = y.TrailerNavigation.TrailerCommonNavigation.Location,
                        TrailerTypeNavigation = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation == null ? null : new TrailerType() {
                            Id = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation.Id,
                            Timestamp = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation.Timestamp,
                            Status = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation.Status,
                            Size = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation.Size,
                            TrailerClass = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClass,
                            TrailerClassNavigation = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation == null ? null : new TrailerClass() {
                                Id = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Id,
                                Timestamp = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Timestamp,
                                Name = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Name,
                                Description = y.TrailerNavigation.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Description
                            }
                        }
                    },
                    Plates = (ICollection<Plate>)y.TrailerNavigation.Plates.Select(p => new Plate() {
                        Id = p.Id,
                        Timestamp = p.Timestamp,
                        Status = p.Status,
                        Identifier = p.Identifier,
                        State = p.State,
                        Country = p.Country,
                        Expiration = p.Expiration,
                        Truck = p.Truck,
                        Trailer = p.Trailer
                    })
                },
                TruckExternalNavigation = y.TruckExternalNavigation == null ? null : new TruckExternal() {
                    Id = y.TruckExternalNavigation.Id,
                    Timestamp = y.TruckExternalNavigation.Timestamp,
                    Status = y.TruckExternalNavigation.Status,
                    Common = y.TruckExternalNavigation.Common,
                    MxPlate = y.TruckExternalNavigation.MxPlate,
                    UsaPlate = y.TruckExternalNavigation.UsaPlate,
                    Carrier = y.TruckExternalNavigation.Carrier,
                    Vin = y.TruckExternalNavigation.Vin,
                    TruckCommonNavigation = y.TruckExternalNavigation.TruckCommonNavigation == null ? null : new TruckCommon() {
                        Id = y.TruckExternalNavigation.TruckCommonNavigation.Id,
                        Timestamp = y.TruckExternalNavigation.TruckCommonNavigation.Timestamp,
                        Status = y.TruckExternalNavigation.TruckCommonNavigation.Id,
                        Economic = y.TruckExternalNavigation.TruckCommonNavigation.Economic,
                        Location = y.TruckExternalNavigation.TruckCommonNavigation.Location,
                        Situation = y.TruckExternalNavigation.TruckCommonNavigation.Situation,
                    }
                },
                TruckNavigation = y.TruckNavigation == null ? null : new Truck() {
                    Id = y.TruckNavigation.Id,
                    Timestamp = y.TruckNavigation.Timestamp,
                    Status = y.TruckNavigation.Status,
                    Sct = y.TruckNavigation.Sct,
                    Common = y.TruckNavigation.Common,
                    Motor = y.TruckNavigation.Motor,
                    Model = y.TruckNavigation.Model,
                    Maintenance = y.TruckNavigation.Maintenance,
                    Insurance = y.TruckNavigation.Insurance,
                    Carrier = y.TruckNavigation.Carrier,
                    CarrierNavigation = y.TruckNavigation.CarrierNavigation == null ? null : new Carrier() {
                        Id = y.TruckNavigation.CarrierNavigation.Id,
                        Status = y.TruckNavigation.CarrierNavigation.Status,
                        Name = y.TruckNavigation.CarrierNavigation.Name,
                        Approach = y.TruckNavigation.CarrierNavigation.Approach,
                        Address = y.TruckNavigation.CarrierNavigation.Address,
                        Usdot = y.TruckNavigation.CarrierNavigation.Usdot,
                        ApproachNavigation = y.TruckNavigation.CarrierNavigation.ApproachNavigation == null ? null : new Approach() {
                            Id = y.TruckNavigation.CarrierNavigation.ApproachNavigation.Id,
                            Timestamp = y.TruckNavigation.CarrierNavigation.ApproachNavigation.Timestamp,
                            Status = y.TruckNavigation.CarrierNavigation.ApproachNavigation.Status,
                            Enterprise = y.TruckNavigation.CarrierNavigation.ApproachNavigation.Enterprise,
                            Personal = y.TruckNavigation.CarrierNavigation.ApproachNavigation.Personal,
                            Alternative = y.TruckNavigation.CarrierNavigation.ApproachNavigation.Alternative,
                            Email = y.TruckNavigation.CarrierNavigation.ApproachNavigation.Email,
                        },
                        UsdotNavigation = y.TruckNavigation.CarrierNavigation.UsdotNavigation == null ? null : new Usdot() {
                            Id = y.TruckNavigation.CarrierNavigation.UsdotNavigation.Id,
                            Timestamp = y.TruckNavigation.CarrierNavigation.UsdotNavigation.Timestamp,
                            Status = y.TruckNavigation.CarrierNavigation.UsdotNavigation.Status,
                            Mc = y.TruckNavigation.CarrierNavigation.UsdotNavigation.Mc,
                            Scac = y.TruckNavigation.CarrierNavigation.UsdotNavigation.Scac,
                        },
                    },
                    Vin = y.TruckNavigation.Vin,
                    SctNavigation = y.TruckNavigation.SctNavigation,
                    VehiculeModelNavigation = y.TruckNavigation.VehiculeModelNavigation == null? null : new VehiculeModel() {
                        Id = y.TruckNavigation.VehiculeModelNavigation.Id,
                        Timestamp = y.TruckNavigation.VehiculeModelNavigation.Timestamp,
                        Status = y.TruckNavigation.VehiculeModelNavigation.Status,
                        Name = y.TruckNavigation.VehiculeModelNavigation.Name,
                        Year = y.TruckNavigation.VehiculeModelNavigation.Year,
                        Manufacturer = y.TruckNavigation.VehiculeModelNavigation.Manufacturer,
                        ManufacturerNavigation = y.TruckNavigation.VehiculeModelNavigation.ManufacturerNavigation == null ? null : new Manufacturer() {
                            Id = y.TruckNavigation.VehiculeModelNavigation.ManufacturerNavigation.Id,
                            Timestamp = y.TruckNavigation.VehiculeModelNavigation.ManufacturerNavigation.Timestamp,
                            Name = y.TruckNavigation.VehiculeModelNavigation.ManufacturerNavigation.Name,
                            Description = y.TruckNavigation.VehiculeModelNavigation.ManufacturerNavigation.Description,
                        },

                    },
                    TruckCommonNavigation = y.TruckNavigation.TruckCommonNavigation == null ? null : new TruckCommon() {
                        Id = y.TruckNavigation.TruckCommonNavigation.Id,
                        Timestamp = y.TruckNavigation.TruckCommonNavigation.Timestamp,
                        Status = y.TruckNavigation.TruckCommonNavigation.Status,
                        Economic = y.TruckNavigation.TruckCommonNavigation.Economic,
                        Location = y.TruckNavigation.TruckCommonNavigation.Location,
                        Situation = y.TruckNavigation.TruckCommonNavigation.Situation,
                    },
                    Plates = (ICollection<Plate>)y.TruckNavigation.Plates.Select(p => new Plate() {
                        Id = p.Id,
                        Timestamp = p.Timestamp,
                        Status = p.Status,
                        Identifier = p.Identifier,
                        State = p.State,
                        Country = p.Country,
                        Expiration = p.Expiration,
                        Truck = p.Truck,
                        Trailer = p.Trailer
                    })
                },
                LoadTypeNavigation = y.LoadTypeNavigation == null ? null : new LoadType() {
                    Id = y.LoadTypeNavigation.Id,
                    Timestamp = y.LoadTypeNavigation.Timestamp,
                    Name = y.LoadTypeNavigation.Name,
                    Description = y.LoadTypeNavigation.Description
                },
                SectionNavigation = y.SectionNavigation == null ? null : new Section() {
                    Id = y.SectionNavigation.Id,
                    Timestamp = y.SectionNavigation.Timestamp,
                    Status = y.SectionNavigation.Status,
                    Name = y.SectionNavigation.Name,
                    Yard = y.SectionNavigation.Yard,
                    Capacity = y.SectionNavigation.Capacity,
                    Ocupancy = y.SectionNavigation.Ocupancy,
                    LocationNavigation = y.SectionNavigation.LocationNavigation == null ? null : new Location() {
                        Id = y.SectionNavigation.LocationNavigation.Id,
                        Timestamp = y.SectionNavigation.LocationNavigation.Timestamp,
                        Status = y.SectionNavigation.LocationNavigation.Status,
                        Name = y.SectionNavigation.LocationNavigation.Name,
                        Address = y.SectionNavigation.LocationNavigation.Address
                    }
                }


            });;
    }
    /// <summary>
    /// This method calculate the ocupancy values, for previous and new selected sections, 
    /// based on log type (entry or departure), previous and new section selection, and trucks-trailers selection.
    /// </summary>
    /// <param name="newYardlog">
    /// newest log record.
    /// </param>
    /// <param name="previousYardlog">
    /// previous log record, stored in db.
    /// </param>
    private void CalculateSections(YardLog newYardlog, YardLog previousYardlog) {

        // Quantity to sum or subtract to sections, based on truck + trailer.
        int newLogQuantity = 1;
        int previousLogQuantity = 1;
        if (newYardlog.TrailerNavigation != null || newYardlog.TrailerExternalNavigation != null) newLogQuantity++;
        if (previousYardlog.TrailerNavigation != null || previousYardlog.TrailerExternalNavigation != null) previousLogQuantity++;

        bool isPreviousSection = previousYardlog.SectionNavigation != null;
        // Check if is necesary update some section value:
        if ((newYardlog.Entry != previousYardlog.Entry) || (previousYardlog.SectionNavigation?.Id != newYardlog.SectionNavigation?.Id)) {
            // Attach previous section to the context for value updates.
            if (isPreviousSection) Database.Attach(previousYardlog.SectionNavigation!);

            //Check if section has changed (selected another section or adding one):
            if (previousYardlog.SectionNavigation?.Id != newYardlog.SectionNavigation?.Id) {
                // If Section is different, then update truck and trailer locations.

                if (newYardlog.Entry) {
                    // If the log is an entry, then change only ocupancy for both sections.
                    if (previousYardlog.Entry) {
                        // New section assigned:
                        newYardlog.SectionNavigation!.Ocupancy += newLogQuantity;
                        // Previous section:
                        if (isPreviousSection) previousYardlog.SectionNavigation!.Ocupancy -= previousLogQuantity;

                    } else {
                        //If previous entry is false, then:
                        newYardlog.SectionNavigation!.Ocupancy += newLogQuantity;
                        // Previous section. Sum +1 to ocupancy due the log was marked has departure:
                        //previousDeepCopy.SectionNavigation.Ocupancy += previousLogQuantity;
                    }
                } else {
                    // If the previous log was an entry,and the new one is a departure, then change only the last section.
                    if (previousYardlog.Entry) {

                        // Substract quantity to Previous section:
                        if (isPreviousSection) previousYardlog.SectionNavigation!.Ocupancy -= previousLogQuantity;
                        // Remove unnecesary section relationship.
                        newYardlog.Section = null;
                        newYardlog.SectionNavigation = null;

                    } else {
                        //Note: For the new section is not necesary update the ocupancy when the new log is set has departure,
                        //due the truck and trailer never has been registered in that section.

                        // Previous section. set -1 to ocupancy due the log was marked has departure:
                        if (isPreviousSection) previousYardlog.SectionNavigation!.Ocupancy += previousLogQuantity;
                    }
                }

            } else {
                // If section has no changed:
                if (newYardlog.Entry) {
                    if (previousYardlog.Entry) {
                        //Add the new quantity if has changed.
                        newYardlog.SectionNavigation!.Ocupancy += -previousLogQuantity + newLogQuantity;
                    } else {
                        //revert the previous subtacted quantity and add the new quantity.
                        newYardlog.SectionNavigation!.Ocupancy += newLogQuantity;
                    }
                } else {
                    if (previousYardlog.Entry) {
                        //subtract the new quantity if has changed.
                        if (isPreviousSection) previousYardlog.SectionNavigation!.Ocupancy -= previousLogQuantity;
                        // Remove unnecesary section relationship.
                        newYardlog.Section = null;
                        newYardlog.SectionNavigation = null;
                    } else {
                        //revert the previous subtacted quantity and add the new quantity.
                        // Check for operators issues: ocupancy = - (-X quantity).
                        newYardlog.SectionNavigation!.Ocupancy -= -previousLogQuantity + newLogQuantity;
                    }
                }
            }
        }
    }
    /// <summary>
    /// Set the location and situation values for common truck and trailers objects.
    /// </summary>
    /// <param name="situation">
    /// Situation ID to assing in common object.
    /// </param>
    /// <param name="common">
    /// Common object. ONLY trucks and trailers common objects are valid.
    /// </param>
    /// <param name="locationID">
    /// Location id to assign. Can be null.
    /// </param>
    private void CommonConfigurator(int situation, Object? common, int? locationID) {
        if(common != null) {
            if (common is TruckCommon truckCommon) {
                truckCommon.Location = locationID;
                truckCommon.LocationNavigation = null;
                truckCommon.Situation = situation;
            }else if(common is TrailerCommon trailerCommon) {
                trailerCommon.Location = locationID;
                trailerCommon.LocationNavigation = null;
                trailerCommon.Situation = situation;
            }
            
        }
    }
    /// <summary>
    /// Update the location and situation based on log section and entry, for trucks and trailers.
    /// Situation for a log is: situation = 1; "Parked in yard". situation = 2; "In transit".
    /// Location assignment is based on last section id asigned for an entry log form.
    /// </summary>
    /// <param name="newYardlog">
    /// The newest yardlog record to use has base to override the previous yardlog record version.
    /// </param>
    /// <param name="previousYardlog">
    /// The previous(old) yardlog record version stored in db. This record will be overrided by the newYardlog record
    /// </param>

    private void setCommonNavigators(YardLog newYardlog, YardLog previousYardlog) {
        // Check the log type.
        if (newYardlog.Entry) {
            //Override location and situation for trucks and trailers.
            //FIX sometimes the truck situation not updated
            // --> Setting trucks.
            CommonConfigurator(1, newYardlog.TruckNavigation?.TruckCommonNavigation, newYardlog.SectionNavigation!.Yard);
            CommonConfigurator(1, newYardlog.TruckExternalNavigation?.TruckCommonNavigation, newYardlog.SectionNavigation!.Yard);
            
            // --> Setting trailers.
            CommonConfigurator(1, newYardlog.TrailerNavigation?.TrailerCommonNavigation, newYardlog.SectionNavigation!.Yard);
            CommonConfigurator(1, newYardlog.TrailerExternalNavigation?.TrailerCommonNavigation, newYardlog.SectionNavigation!.Yard);

        } else {
            //Removing location and setting situation for trailers and trucks.
            // --> Setting trucks.
            CommonConfigurator(2, newYardlog.TruckNavigation?.TruckCommonNavigation, null);
            CommonConfigurator(2, newYardlog.TruckExternalNavigation?.TruckCommonNavigation, null);

            // --> Setting trailers.
            CommonConfigurator(2, newYardlog.TrailerNavigation?.TrailerCommonNavigation, null);
            CommonConfigurator(2, newYardlog.TrailerExternalNavigation?.TrailerCommonNavigation, null);
        }
    }
    public async Task<SetViewOut<YardLog>> View(SetViewOptions<YardLog> options) {
       
        return await YardLogs.View(options, Include);
    }

    public async Task<SetBatchOut<YardLog>> Create(YardLog[] yardLog) {
        return await this.YardLogs.Create(yardLog);
    }

    public async Task<RecordUpdateOut<YardLog>> Update(YardLog YardLog) {

            // Evaluate record.
            YardLog.EvaluateWrite();
            // Check if the trailer currently exist in database.
            // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
            YardLog? current = await Include(Database.YardLogs)
                .Where(i => i.Id == YardLog.Id)
                .FirstOrDefaultAsync();

            // If yardlog not exist in database, then use the generic update method.
            if (current == null) {
                return await YardLogs.Update(YardLog, Include);
            }
            // Save a deep copy before changes.
            YardLog previousDeepCopy = current.DeepCopy();

            // Clear the navigation to avoid duplicated tracking issues.
            current.DriverExternalNavigation = null;
            current.DriverNavigation = null;
            current.LoadTypeNavigation = null;
            current.SectionNavigation = null;
            current.TrailerExternalNavigation = null;
            current.TrailerNavigation = null;
            current.TruckExternalNavigation = null;
            current.TruckNavigation = null;

            Database.Attach(current);

            // Update the main model properties.
            EntityEntry previousEntry = Database.Entry(current);
            previousEntry.CurrentValues.SetValues(YardLog);

            // ---> Update Driver navigation
            if (YardLog.DriverNavigation != null) {
                current.Driver = YardLog.DriverNavigation!.Id;
                current.DriverNavigation = YardLog.DriverNavigation;
            }

            // ---> Update Driver external navigation
            if (YardLog.DriverExternalNavigation != null) {
                current.DriverExternal = YardLog.DriverExternalNavigation!.Id;
                current.DriverExternalNavigation = YardLog.DriverExternalNavigation;
            }

            // ---> Update Load Type navigation
            if (YardLog.LoadTypeNavigation != null) {
                current.LoadType = YardLog.LoadTypeNavigation!.Id;
                current.LoadTypeNavigation = YardLog.LoadTypeNavigation;
            }

            // ---> Update TrailerExternal navigation
            if (YardLog.TrailerExternalNavigation != null) {
                current.TrailerExternal = YardLog.TrailerExternalNavigation!.Id;
                current.TrailerExternalNavigation = YardLog.TrailerExternalNavigation;
            }

            // ---> Update Trailer navigation
            if (YardLog.TrailerNavigation != null) {
                current.Trailer = YardLog.TrailerNavigation!.Id;
                current.TrailerNavigation = YardLog.TrailerNavigation;
            }

            // ---> Update Truck navigation
            if (YardLog.TruckNavigation != null) {
                // Remove navigations to avoid references issues.
                YardLog.TruckNavigation!.SctNavigation = null;
                YardLog.TruckNavigation!.CarrierNavigation = null;
                current.Truck = YardLog.TruckNavigation!.Id;
                current.TruckNavigation = YardLog.TruckNavigation;
            }

            // ---> Update Truck external navigation
            if (YardLog.TruckExternalNavigation != null) {
                current.TruckExternal = YardLog.TruckExternalNavigation!.Id;
                current.TruckExternalNavigation = YardLog.TruckExternalNavigation;
            }

            // ---> Update section navigation
            if (YardLog.SectionNavigation != null) {
                // override section navigation values.
                current.Section = YardLog.SectionNavigation!.Id;
                current.SectionNavigation = YardLog.SectionNavigation;
                // --> Change the ocupancy values for sections
                // Check if yardlog is entry or departure:
                // Note: For departure logs section navigation is not required.
                CalculateSections(current, previousDeepCopy);
            }

            setCommonNavigators(current, previousDeepCopy);

            await Database.SaveChangesAsync();
            Disposer?.Push(Database, YardLog);
            // Get the lastest record data from database.
            YardLog? lastestRecord = await Include(Database.YardLogs)
                .Where(i => i.Id == YardLog.Id)
                .FirstOrDefaultAsync();

            return new RecordUpdateOut<YardLog> {
                Previous = previousDeepCopy,
                Updated = lastestRecord ?? YardLog,
            };
        
    }

    public async Task<YardLog> Delete(int Id) {
        return await YardLogs.Delete(Id);
    }

    public Task<SetViewOut<YardLog>> ViewInventory(SetViewOptions<YardLog> Options) {
        return YardLogs.ViewInventory(Options);
    }
}
