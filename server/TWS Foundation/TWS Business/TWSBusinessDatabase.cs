using CSM_Foundation.Database.Bases;


using Microsoft.EntityFrameworkCore;

using TWS_Business.Sets;

namespace TWS_Business;

public class TWSBusinessDatabase : BDatabase_SQLServer<TWSBusinessDatabase> {
    public TWSBusinessDatabase(DbContextOptions<TWSBusinessDatabase> options)
        : base("TWSB", options) {
    }

    public TWSBusinessDatabase()
        : base("TWSB") {
    }

    public virtual DbSet<Insurance> Insurances { get; set; } = default!;

    public virtual DbSet<Maintenance> Maintenances { get; set; } = default!;

    public virtual DbSet<Manufacturer> Manufacturers { get; set; } = default!;

    public virtual DbSet<Plate> Plates { get; set; } = default!;

    public virtual DbSet<Sct> Scts { get; set; } = default!;

    public virtual DbSet<Situation> Situations { get; set; } = default!;

    public virtual DbSet<Status> Statuses { get; set; } = default!;

    public virtual DbSet<TruckH> HPTrucks { get; set; } = default!;

    public virtual DbSet<Truck> Trucks { get; set; } = default!;

    public virtual DbSet<Carrier> Carriers { get; set; } = default!;

    public virtual DbSet<Approach> Approaches { get; set; } = default!;

    public virtual DbSet<Usdot> Usdots { get; set; } = default!;

    public virtual DbSet<Address> Addresses { get; set; } = default!;

    public virtual DbSet<Trailer> Trailers { get; set; } = default!;

    public virtual DbSet<TrailerCommon> TrailersCommons { get; set; } = default!;

    public virtual DbSet<TrailerExternal> TrailersExternals { get; set; } = default!;

    public virtual DbSet<Identification> Identifications { get; set; } = default!;

    public virtual DbSet<Driver> Drivers { get; set; } = default!;

    public virtual DbSet<DriverCommon> DriversCommons { get; set; } = default!;

    public virtual DbSet<DriverExternal> DriverExternals { get; set; } = default!;

    public virtual DbSet<TrailerClass> TrailerClasses { get; set; } = default!;

    public virtual DbSet<Location> Locations { get; set; } = default!;

    public virtual DbSet<LoadType> LoadTypes { get; set; } = default!;

    public virtual DbSet<Section> Sections { get; set; } = default!;

    public virtual DbSet<YardLog> YardLogs { get; set; } = default!;

    public virtual DbSet<VehiculeModel> VehiculesModels { get; set; } = default!;

    public virtual DbSet<TrailerType> TrailersTypes { get; set; } = default!;

    public virtual DbSet<TrailerType> TrucksInventories { get; set; } = default!;
}
