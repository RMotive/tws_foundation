﻿using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;
using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class YardLogsService 
    : IYardLogsService {
    private readonly YardLogsDepot YardLogs;

    public YardLogsService(
       YardLogsDepot YardLogs) {
        
        this.YardLogs = YardLogs;
   
    }
    private IQueryable<YardLog> Include(IQueryable<YardLog> query) {
        return query
            .Include(t => t.DriverExternalNavigation)
                .ThenInclude(i => i!.IdentificationNavigation)
            .Include(t => t.DriverExternalNavigation)
                .ThenInclude(i => i!.DriverCommonNavigation)

            .Include(t => t.DriverNavigation)
                .ThenInclude(d => d!.EmployeeNavigation)
                    .ThenInclude(e => e!.IdentificationNavigation)

            .Include(t => t.DriverNavigation)
                .ThenInclude(d => d!.DriverCommonNavigation)

            .Include(t => t.TrailerExternalNavigation)
                .ThenInclude(d => d!.TrailerCommonNavigation)
                    .ThenInclude(d => d!.TrailerTypeNavigation)
                        .ThenInclude(d => d!.TrailerClassNavigation)
                    
            .Include(t => t.TrailerNavigation)
                .ThenInclude(d => d!.TrailerCommonNavigation)
                  .ThenInclude(t => t!.TrailerTypeNavigation)
                    .ThenInclude(t => t!.TrailerClassNavigation)

            .Include(t => t.TrailerNavigation)
                .ThenInclude(t => t!.CarrierNavigation)
            .Include(t => t.TrailerNavigation)
                .ThenInclude(t => t!.CarrierNavigation)
                    .ThenInclude(t => t!.AddressNavigation)
            .Include(t => t.TrailerNavigation)
                .ThenInclude(t => t!.CarrierNavigation)
                    .ThenInclude(t => t!.UsdotNavigation)
            .Include(t => t.TrailerNavigation)
                .ThenInclude(t => t!.CarrierNavigation)
                    .ThenInclude(t => t!.ApproachNavigation)

            .Include(t => t.TrailerNavigation)
                .ThenInclude(t => t!.VehiculesModelsNavigation)

            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.TruckCommonNavigation)

            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.VehiculeModelNavigation)

            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.CarrierNavigation)
            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.CarrierNavigation)
                    .ThenInclude(t => t!.AddressNavigation)
            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.CarrierNavigation)
                    .ThenInclude(t => t!.UsdotNavigation)
            .Include(t => t.TruckNavigation)
                .ThenInclude(t => t!.CarrierNavigation)
                    .ThenInclude(t => t!.ApproachNavigation)

            .Include(t => t.TruckExternalNavigation)
                .ThenInclude(t => t!.TruckCommonNavigation)

            .Include(t => t.LoadTypeNavigation)

            .Include(t => t.SectionNavigation)
                .ThenInclude(t => t!.LocationNavigation)
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
                    VehiculesModelsNavigation = y.TrailerNavigation.VehiculesModelsNavigation == null ? null : new VehiculeModel() {
                        Id = y.TrailerNavigation.VehiculesModelsNavigation.Id,
                        Timestamp = y.TrailerNavigation.VehiculesModelsNavigation.Timestamp,
                        Status = y.TrailerNavigation.VehiculesModelsNavigation.Status,
                        Name = y.TrailerNavigation.VehiculesModelsNavigation.Name,
                        Year = y.TrailerNavigation.VehiculesModelsNavigation.Year,
                        Manufacturer = y.TrailerNavigation.VehiculesModelsNavigation.Manufacturer,
                        ManufacturerNavigation = y.TrailerNavigation.VehiculesModelsNavigation.ManufacturerNavigation,
                    },
                    CarrierNavigation = y.TrailerNavigation.CarrierNavigation,
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
                    CarrierNavigation = y.TruckNavigation.CarrierNavigation,
                    Vin = y.TruckNavigation.Vin,
                    SctNavigation = y.TruckNavigation.SctNavigation,
                    VehiculeModelNavigation = y.TruckNavigation.VehiculeModelNavigation == null? null : new VehiculeModel() {
                        Id = y.TruckNavigation.VehiculeModelNavigation.Id,
                        Timestamp = y.TruckNavigation.VehiculeModelNavigation.Timestamp,
                        Status = y.TruckNavigation.VehiculeModelNavigation.Status,
                        Name = y.TruckNavigation.VehiculeModelNavigation.Name,
                        Year = y.TruckNavigation.VehiculeModelNavigation.Year,
                        Manufacturer = y.TruckNavigation.VehiculeModelNavigation.Manufacturer,
                        ManufacturerNavigation = y.TruckNavigation.VehiculeModelNavigation.ManufacturerNavigation,

                    },
                    TruckCommonNavigation = y.TruckNavigation.TruckCommonNavigation == null ? null : new TruckCommon() {
                        Id = y.TruckNavigation.TruckCommonNavigation.Id,
                        Timestamp = y.TruckNavigation.TruckCommonNavigation.Timestamp,
                        Status = y.TruckNavigation.TruckCommonNavigation.Id,
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
    public async Task<SetViewOut<YardLog>> View(SetViewOptions<YardLog> options) {
       
        return await YardLogs.View(options, Include);
    }

    public async Task<SetBatchOut<YardLog>> Create(YardLog[] yardLog) {
        return await this.YardLogs.Create(yardLog);
    }
    public async Task<RecordUpdateOut<YardLog>> Update(YardLog yardLog, bool updatePivot = false) {

        return await YardLogs.Update(yardLog, Include) ;
    }

    public async Task<YardLog> Delete(int Id) {
        return await YardLogs.Delete(Id);
    }

    public Task<SetViewOut<YardLog>> ViewInventory(SetViewOptions<YardLog> Options) {
        return YardLogs.ViewInventory(Options);
    }
}
