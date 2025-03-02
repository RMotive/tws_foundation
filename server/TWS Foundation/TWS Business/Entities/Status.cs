using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Entities;
public partial class Status
: BBusinessEntity, IEntity_Name {

    public string Name { get; set; } = default!;
    public string? Description { get; set; }

    /// <summary>
    ///     <see cref="DriverCommon"/> referencing to this <see cref="Status"/>.
    /// </summary>
    public ICollection<DriverCommon> Drivers { get; set; } = [];

    /// <summary>
    ///     <see cref="TruckCommon"/> referencing to this <see cref="Status"/>.
    /// </summary>
    public ICollection<TruckCommon> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="TrailerCommon"/> referencing to this <see cref="Status"/>
    /// </summary>
    public ICollection<TrailerCommon> Trailers { get; set; } = [];

    /// <summary>
    ///     <see cref="SCT"/> dependants from this <see cref="Status"/>
    /// </summary>
    public ICollection<SCT> SCTs { get; set; } = [];


    public virtual ICollection<VehiculeModel> VehiculeModels { get; set; } = [];

    public virtual ICollection<TrailerType> TrailerTypes { get; set; } = [];

    public virtual ICollection<Section> Sections { get; set; } = [];

    public virtual ICollection<Employee> Employees { get; set; } = [];

    public virtual ICollection<Identification> Identifications { get; set; } = [];

    public virtual ICollection<Location> Locations { get; set; } = [];

    public virtual ICollection<Carrier> Carriers { get; set; } = [];

    public virtual ICollection<USDOT> Usdots { get; set; } = [];

    public virtual ICollection<Approach> Contacts { get; set; } = [];

    public virtual ICollection<Insurance> Insurances { get; set; } = [];

    public virtual ICollection<Maintenance> Maintenances { get; set; } = [];

    public virtual ICollection<Plate> Plates { get; set; } = [];

    public virtual ICollection<TruckH> TrucksHistories { get; set; } = [];

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

    protected override void DesignEntity(ModelBuilder Builder) {
        Builder.Entity<Status>(Entity => {
        });
    }
}