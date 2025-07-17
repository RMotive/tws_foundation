using System.Reflection;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Bases;
using CSM_Foundation.Database.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Maintenances;
using TWS_Business.Entities.USDOTs;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business;

/// <summary>
///     
/// </summary>
public class DesignDatabaseFactory : IDesignTimeDbContextFactory<Database> {
    public Database CreateDbContext(string[] args) {
        return new Database();
    }
}

/// <summary>
///     [Interface] for [TWS Business] database implementations.
/// </summary>
public interface IDatabase {

    /// <summary>
    ///     [Employee] [Entity] database Entity.
    /// </summary>
    DbSet<Employee> Employees { get; set; }
}

/// <summary>
///     
/// </summary>
public class Database
    : BDatabase_SQLServer<Database>, IDatabase {

    public const string SIGN = "TWSB";

    /// <summary>
    /// /
    /// </summary>
    /// <param name="Options"></param>
    public Database(DbContextOptions<Database> Options)
        : base(SIGN, Options) {
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Connection"></param>
    public Database(ConnectionOptions Connection)
        : base(SIGN, Connection) {
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <param name="Connection"></param>
    public Database(DbContextOptions<Database> Options, ConnectionOptions Connection)
        : base(SIGN, Connection, Options) {
    }

    /// <summary>
    /// 
    /// </summary>
    public Database()
        : base(SIGN) {
    }

    #region Drivers

    public DbSet<Driver> Drivers { get; set; } = default!;

    public DbSet<Driver_Common> DriversCommons { get; set; } = default!;

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

    public DbSet<Waypoint> Waypoints { get; set; } = default!;


    #endregion

    #region YardLogs

    public DbSet<LoadType> LoadTypes { get; set; } = default!;

    public DbSet<YardLog> YardLogs { get; set; } = default!;

    #endregion

    #region Human Resources

    public DbSet<Employee> Employees { get; set; } = default!;

    public DbSet<Identification> Identifications { get; set; } = default!;

    public DbSet<Approach> Approaches { get; set; } = default!;

    #endregion

    #region State 

    public DbSet<Status> Statuses { get; set; } = default!;

    public DbSet<Situation> Situations { get; set; } = default!;

    #endregion
}
