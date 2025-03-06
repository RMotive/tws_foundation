using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

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

public class DesignDatabaseFactory : IDesignTimeDbContextFactory<Database> {
    public Database CreateDbContext(string[] args) {
        return new Database();
    }
}

/// <summary>
///     
/// </summary>
public class Database
    : BDatabase_SQLServer<Database>, IDatabase {

    public Database(DbContextOptions<Database> options)
        : base("TWSB", options) {
    }

    public Database()
        : base("TWSB") {
    }

    #region Drivers

    public DbSet<Driver> Drivers { get; set; } = default!;
    public DbSet<DriverCommon> DriversCommons { get; set; } = default!;
    public DbSet<DriverExternal> DriversExternals { get; set; } = default!;

    #endregion

    #region Vehicules

    public DbSet<Plate> Plates { get; set; } = default!;

    public DbSet<Carrier> Carriers { get; set; } = default!;

    public DbSet<Insurance> Insurances { get; set; } = default!;

    public DbSet<Maintenance> Maintenances { get; set; } = default!;

    public DbSet<Manufacturer> Manufacturers { get; set; } = default!;

    public DbSet<VehiculeModel> VehiculesModels { get; set; } = default!;

    #endregion

    #region Trucks

    public DbSet<SCT> SCTs { get; set; } = default!;

    public DbSet<USDOT> USDOTs { get; set; } = default!;

    public DbSet<Truck> Trucks { get; set; } = default!;

    public DbSet<Truck_Common> TrucksCommons { get; set; } = default!;

    public DbSet<TruckExternal> TrucksExternals { get; set; } = default!;

    #endregion

    #region Trailers

    public DbSet<Trailer> Trailers { get; set; } = default!;

    public DbSet<Trailer_Type> TrailerTypes { get; set; } = default!;

    public DbSet<Trailer_Class> TrailerClasses { get; set; } = default!;

    public DbSet<Trailer_Common> TrailersCommons { get; set; } = default!;

    public DbSet<TrailerExternal> TrailersExternals { get; set; } = default!;

    #endregion

    #region Locations

    public DbSet<Location> Locations { get; set; } = default!;

    public DbSet<Address> Addresses { get; set; } = default!;

    public DbSet<Section> Sections { get; set; } = default!;

    #endregion

    #region YardLogs

    public DbSet<LoadType> LoadTypes { get; set; } = default!;

    public DbSet<YardLog> YardLogs { get; set; } = default!;

    #endregion

    #region Human Resources

    public DbSet<Employee> Employees { get; set; }

    public DbSet<Identification> Identifications { get; set; } = default!;

    public DbSet<Approach> Approaches { get; set; } = default!;

    #endregion

    #region State 

    public DbSet<Status> Statuses { get; set; } = default!;

    public DbSet<Situation> Situations { get; set; } = default!;

    #endregion

    #region Inventories

    public DbSet<TruckEntry> TrucksInventories { get; set; } = default!;

    #endregion
}
