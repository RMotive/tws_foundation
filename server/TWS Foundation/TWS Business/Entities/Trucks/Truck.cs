using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Carriers;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Maintenances;
using TWS_Business.Entities.Plates;
using TWS_Business.Entities.SCTs;

namespace TWS_Business.Entities.Trucks;

/// <summary>
///     [Entity] that represents a physical <see cref="Truck"/> for business operations.
/// </summary>
public class Truck
    : TWSScopeEntity<Truck_Common>, IHistorical<Truck_History> {

    #region Properties

    /// <summary>
    ///     Motor identifier.
    /// </summary>
    public string? Motor { get; set; }

    /// <summary>
    ///     Vehicule identifier number.
    /// </summary>
    [StringLength(17, MinimumLength = 17)]
    public string VIN { get; set; } = string.Empty;

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Carriers.Carrier"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Carrier Carrier { get; set; } = default!;

    /// <summary>
    ///     <see cref="VehiculeModel"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public VehiculeModel Model { get; set; } = default!;

    /// <summary>
    ///     <see cref="SCTs.SCT"/> information.
    /// </summary>
    public SCT? SCT { get; set; }

    /// <summary>
    ///     <see cref="Maintenances.Maintenance"/> information.
    /// </summary>
    public Maintenance? Maintenance { get; set; }

    /// <summary>
    ///     <see cref="Insurances.Insurance"/> information.
    /// </summary>
    public Insurance? Insurance { get; set; }

    /// <summary>
    ///     <see cref="Plate"/>s referencing this <see cref="Truck"/>.
    /// </summary>
    public ICollection<Plate> Plates { get; set; } = [];

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="YardLog"/>s referencing this <see cref="Truck"/>
    /// </summary>
    public ICollection<YardLog> YardLogs { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck"/> history entries.
    /// </summary>
    public ICollection<Truck_History> History { get; set; } = [];

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            ( nameof(VIN), [ new UniqueValidator(), new LengthValidator(17, 17) ] ),
        ];
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Motor)).HasMaxLength(16);
        etBuilder.Property(nameof(VIN)).HasMaxLength(17).IsRequired();

        etBuilder.Link<Truck, Carrier>(nameof(Carrier), Required: true);
        etBuilder.Link<Truck, VehiculeModel>(nameof(Model), Required: true);

        etBuilder.Link<Truck, SCT>(nameof(SCT));
        etBuilder.Link<Truck, Maintenance>(nameof(Maintenance));
    }
}
