using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
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
///     [Entity_H] History entry for <see cref="Truck"/> Entity.
/// </summary>
public class Truck_History
: TWSHistory<Truck> {

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
    ///     <see cref="Carrier_History"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Carrier_History CarrierHistory { get; set; } = default!;

    /// <summary>
    ///     <see cref="VehiculeModel"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public VehiculeModel Model { get; set; } = default!;

    /// <summary>
    ///     <see cref="SCT"/> information.
    /// </summary>
    public SCT_History? SCTHistory { get; set; }

    /// <summary>
    ///     <see cref="Maintenance_History"/> information.
    /// </summary>
    public Maintenance_History? MaintenanceHistory { get; set; }

    /// <summary>
    ///     <see cref="Insurances.Insurance"/> information.
    /// </summary>
    public Insurance_History? InsuranceHistory { get; set; }

    /// <summary>
    ///     <see cref="Plate_History"/>s referencing this <see cref="Truck"/>.
    /// </summary>
    public ICollection<Plate_History> Plates { get; set; } = [];

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            ( nameof(VIN), [ new UniqueValidator(), new LengthValidator(17, 17)] ),
        ];
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Motor)).HasMaxLength(16);

        etBuilder.Property(nameof(VIN)).HasMaxLength(17).IsFixedLength().IsRequired();
        etBuilder.HasIndex(nameof(VIN)).IsUnique();

        etBuilder.Link<Truck_History, Carrier_History>(
            nameof(CarrierHistory),
            TargetReference: nameof(Carrier_History.TrucksHistories),
            Required: true,
            Auto: true
        );
        etBuilder.Link<Truck_History, VehiculeModel>(
            nameof(Model),
            TargetReference: nameof(VehiculeModel.TrucksHistories),
            Required: true,
            Auto: true
        );

        etBuilder.Link<Truck_History, SCT_History>(nameof(SCTHistory), nameof(SCT_History.TrucksHistories));
        etBuilder.Link<Truck_History, Maintenance_History>(nameof(MaintenanceHistory), nameof(Maintenance_History.TrucksHistories));
        etBuilder.Link<Truck_History, Insurance_History>(nameof(InsuranceHistory), nameof(Insurance_History.TrucksHistories));
    }
}