using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;


using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

using TWS_Business.Sets;

namespace TWS_Business;

public partial class TWSBusinessDatabase : BDatabaseSQLS<TWSBusinessDatabase> {
    public TWSBusinessDatabase(DbContextOptions<TWSBusinessDatabase> options)
        : base("TWSB", options) {
    }

    public TWSBusinessDatabase()
        : base("TWSB") {
    }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) {
        optionsBuilder.UseSqlServer("Server=DESKTOP-M2SPTNQ;Database=TWS Business; Trusted_Connection=True; Encrypt=False");

        optionsBuilder.UseLoggerFactory(LoggerFactory.Create(builder => builder.AddDebug()))
                             .EnableSensitiveDataLogging();
    }

    public virtual DbSet<Insurance> Insurances { get; set; }

    public virtual DbSet<Maintenance> Maintenances { get; set; }

    public virtual DbSet<Manufacturer> Manufacturers { get; set; }

    public virtual DbSet<Plate> Plates { get; set; }

    public virtual DbSet<Sct> Scts { get; set; }

    public virtual DbSet<Situation> Situations { get; set; }

    public virtual DbSet<Status> Statuses { get; set; }

    public virtual DbSet<TruckH> HPTrucks { get; set; }

    public virtual DbSet<Truck> Trucks { get; set; }

    public virtual DbSet<Carrier> Carriers { get; set; }

    public virtual DbSet<Approach> Approaches { get; set; }

    public virtual DbSet<Usdot> Usdots { get; set; }

    public virtual DbSet<Address> Addresses { get; set; }

    public virtual DbSet<Trailer> Trailers { get; set; }

    public virtual DbSet<TrailerCommon> TrailersCommons { get; set; }

    public virtual DbSet<TrailerExternal> TrailersExternals { get; set; }

    public virtual DbSet<Identification> Identifications { get; set; }

    public virtual DbSet<Driver> Drivers { get; set; }

    public virtual DbSet<DriverCommon> DriversCommons { get; set; }

    public virtual DbSet<DriverExternal> DriverExternals { get; set; }

    public virtual DbSet<TrailerClass> TrailerClasses { get; set; }

    public virtual DbSet<Location> Locations { get; set; }

    public virtual DbSet<LoadType> LoadTypes { get; set; }

    public virtual DbSet<Section> Sections { get; set; }

    public virtual DbSet<YardLog> YardLogs { get; set; }

    public virtual DbSet<VehiculeModel> VehiculesModels { get; set; }

    public virtual DbSet<TrailerType> TrailersTypes { get; set; }

    public virtual DbSet<TrailerType> TrucksInventories { get; set; }



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
            new UsdotH(),
            new Approach(),
            new ApproachesH(),
            new TruckH()
        ];
    }
    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
