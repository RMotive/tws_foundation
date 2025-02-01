using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;


using Microsoft.EntityFrameworkCore;

using TWS_Business.Sets;

namespace TWS_Business;

public partial class TWSBusinessDatabase : BDatabaseSQLS<TWSBusinessDatabase> {
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

    public virtual DbSet<TruckExternal> TrucksExternals { get; set; } = default!;

    public virtual DbSet<Waypoint> Waypoints { get; set; } = default!;

    protected override void OnModelCreating(ModelBuilder builder) {
        Sct.CreateModel(builder);
        Plate.CreateModel(builder);
        Truck.CreateModel(builder);
        Situation.CreateModel(builder);
        Insurance.CreateModel(builder);
        Maintenance.CreateModel(builder);
        Manufacturer.CreateModel(builder);
        Trailer.CreateModel(builder);
        TrailerClass.CreateModel(builder);
        TrailerCommon.CreateModel(builder);
        TrailerExternal.CreateModel(builder);
        Status.CreateModel(builder);
        Address.CreateModel(builder);
        Approach.CreateModel(builder);
        Carrier.CreateModel(builder);
        Location.CreateModel(builder);
        TruckExternal.CreateModel(builder);
        TruckCommon.CreateModel(builder);
        Identification.CreateModel(builder);
        Employee.CreateModel(builder);
        Driver.CreateModel(builder);
        DriverCommon.CreateModel(builder);
        DriverExternal.CreateModel(builder);
        LoadType.CreateModel(builder);
        Section.CreateModel(builder);
        YardLog.Set(builder);
        TrailerType.CreateModel(builder);
        VehiculeModel.CreateModel(builder);
        TruckH.CreateModel(builder);
        Usdot.CreateModel(builder);
        Usdot.CreateModel(builder);
        UsdotH.CreateModel(builder);
        ApproachesH.CreateModel(builder);
        CarrierH.CreateModel(builder);
        TruckInventory.CreateModel(builder);
        Waypoint.CreateModel(builder);


        OnModelCreatingPartial(builder);
    }

    protected override ISet[] EvaluateFactory() {
        return [
            new Plate(),
            new Manufacturer(),
            new Maintenance(),
            new Insurance(),
            new Situation(),
            new Truck(),
            new TruckCommon(),
            new TruckExternal(),
            new Sct(),
            new Status(),
            new Carrier(),
            new Usdot(),
            new Address(),
            new Trailer(),
            new TrailerClass(),
            new TrailerCommon(),
            new TrailerExternal(),
            new Location(),
            new Identification(),
            new Employee(),
            new Driver(),
            new DriverCommon(),
            new DriverExternal(),
            new LoadType(),
            new Section(),
            new YardLog(),
            new VehiculeModel(),
            new TrailerType(),
            new TruckInventory(),
            new Waypoint(),
            new UsdotH(),
            new Approach(),
            new ApproachesH(),
            new TruckH()

        ];
    }
    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
