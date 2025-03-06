using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities;
using TWS_Business.Entities.Approaches;
using TWS_Business.Entities.Carriers;
using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Maintenances;
using TWS_Business.Entities.Plates;
using TWS_Business.Entities.SCTs;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Trucks;
using TWS_Business.Entities.USDOTs;

namespace TWS_Business;

/// <summary>
///     
/// </summary>
public class BusinessDatabase
    : BDatabase_SQLServer<BusinessDatabase>, IBusinessDatabase {

    public BusinessDatabase(DbContextOptions<BusinessDatabase> options)
        : base("TWSB", options) {
    }

    public BusinessDatabase()
        : base("TWSB") {
    }

    public virtual DbSet<Employee> Employees { get; set; }

    public virtual DbSet<Truck> Trucks { get; set; } = default!;
    public virtual DbSet<Truck_Common> TruckCommons { get; set; } = default!;
    public virtual DbSet<TruckExternal> TruckExternal { get; set; } = default!;


    public virtual DbSet<Trailer> Trailers { get; set; } = default!;
    public virtual DbSet<Trailer_Common> TrailersCommons { get; set; } = default!;
    public virtual DbSet<TrailerExternal> TrailersExternals { get; set; } = default!;


    public virtual DbSet<Driver> Drivers { get; set; } = default!;
    public virtual DbSet<DriverCommon> DriversCommons { get; set; } = default!;
    public virtual DbSet<DriverExternal> DriverExternals { get; set; } = default!;


    public virtual DbSet<Plate> Plates { get; set; } = default!;

    public virtual DbSet<Insurance> Insurances { get; set; } = default!;

    public virtual DbSet<Maintenance> Maintenances { get; set; } = default!;

    public virtual DbSet<Manufacturer> Manufacturers { get; set; } = default!;


    public virtual DbSet<SCT> Scts { get; set; } = default!;

    public virtual DbSet<Situation> Situations { get; set; } = default!;

    public virtual DbSet<Status> Statuses { get; set; } = default!;

    public virtual DbSet<Truck_History> HPTrucks { get; set; } = default!;

    public virtual DbSet<Carrier> Carriers { get; set; } = default!;

    public virtual DbSet<Approach> Approaches { get; set; } = default!;

    public virtual DbSet<USDOT> Usdots { get; set; } = default!;

    public virtual DbSet<Address> Addresses { get; set; } = default!;

    public virtual DbSet<Identification> Identifications { get; set; } = default!;

    public virtual DbSet<Trailer_Class> TrailerClasses { get; set; } = default!;

    public virtual DbSet<Location> Locations { get; set; } = default!;

    public virtual DbSet<LoadType> LoadTypes { get; set; } = default!;

    public virtual DbSet<Section> Sections { get; set; } = default!;

    public virtual DbSet<YardLog> YardLogs { get; set; } = default!;

    public virtual DbSet<VehiculeModel> VehiculesModels { get; set; } = default!;

    public virtual DbSet<Trailer_Type> TrailersTypes { get; set; } = default!;

    public virtual DbSet<TruckEntry> TrucksInventories { get; set; } = default!;
}
