using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;
public partial class Status
: BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public virtual ICollection<TruckCommon> TrucksCommons { get; set; } = [];

    public virtual ICollection<TrailerCommon> TrailersCommons { get; set; } = [];

    public virtual ICollection<DriverCommon> DriversCommons { get; set; } = [];

    public virtual ICollection<Section> Sections { get; set; } = [];

    public virtual ICollection<DriverExternal> DriversExternals { get; set; } = [];

    public virtual ICollection<Driver> Drivers { get; set; } = [];

    public virtual ICollection<Employee> Employees { get; set; } = [];

    public virtual ICollection<Identification> Identifications { get; set; } = [];

    public virtual ICollection<TrailerExternal> TrailersExternals { get; set; } = [];

    public virtual ICollection<TruckExternal> TrucksExternals { get; set; } = [];

    public virtual ICollection<Location> Locations { get; set; } = [];

    public virtual ICollection<Carrier> Carriers { get; set; } = [];

    public virtual ICollection<Usdot> Usdots { get; set; } = [];

    public virtual ICollection<Approach> Contacts { get; set; } = [];

    public virtual ICollection<Insurance> Insurances { get; set; } = [];

    public virtual ICollection<Maintenance> Maintenances { get; set; } = [];

    public virtual ICollection<Plate> Plates { get; set; } = [];

    public virtual ICollection<Sct> Scts { get; set; } = [];

    public virtual ICollection<Trailer> Trailers { get; set; } = [];

    public virtual ICollection<Truck> Trucks { get; set; } = [];

    public virtual ICollection<TruckH> TrucksH { get; set; } = [];

    public virtual ICollection<CarrierH> CarriersH { get; set; } = [];

    public virtual ICollection<InsuranceH> InsurancesH { get; set; } = [];

    public virtual ICollection<MaintenanceH> MaintenancesH { get; set; } = [];

    public virtual ICollection<PlateH> PlatesH { get; set; } = [];

    public virtual ICollection<UsdotH> UsdotsH { get; set; } = [];

    public virtual ICollection<ApproachesH> ContactsH { get; set; } = [];

    public virtual ICollection<SctH> SctsH { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Name), [Required, new LengthValidator(1, 25)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Status>(Entity => {
            Entity.HasKey(e => e.Id);


            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.HasIndex(e => e.Name)
                .IsUnique();

            Entity.Property(e => e.Name)
                .HasMaxLength(25);

            Entity.Property(e => e.Description)
                .HasMaxLength(150);
        });
    }
}