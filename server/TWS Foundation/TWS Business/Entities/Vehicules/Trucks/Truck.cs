using System.ComponentModel.DataAnnotations;

using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Maintenances;

namespace TWS_Business.Entities.Vehicules.Trucks;

/// <summary>
///     [Entity] that represents a physical <see cref="Truck"/> for business operations.
/// </summary>
public class Truck
    : BCommonScopeEntity<Truck_Common> {

    #region Properties

    /// <summary>
    ///     Motor identifier.
    /// </summary>
    [StringLength(16, MinimumLength = 1)]
    public string? Motor { get; set; }

    /// <summary>
    ///     Vehicule identifier number.
    /// </summary>
    [StringLength(17, MinimumLength = 1)]
    public string VIN { get; set; } = string.Empty;

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Vehicules.Carrier"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityRelation]
    public Carrier Carrier { get; set; } = default!;

    /// <summary>
    ///     <see cref="VehiculeModel"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityRelation]
    public VehiculeModel Model { get; set; } = default!;

    /// <summary>
    ///     <see cref="Vehicules.SCT"/> information.
    /// </summary>
    [EntityRelation]
    public SCT? SCT { get; set; }

    /// <summary>
    ///     <see cref="Maintenances.Maintenance"/> information.
    /// </summary>
    [EntityRelation]
    public Maintenance? Maintenance { get; set; }

    /// <summary>
    ///     <see cref="Insurances.Insurance"/> information.
    /// </summary>
    [EntityRelation]
    public Insurance? Insurance { get; set; }

    /// <summary>
    ///     <see cref="Plate"/>s referencing this <see cref="Truck"/>.
    /// </summary>
    [EntityRelation]
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

    protected override void DesignScopeEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Motor)).HasMaxLength(16);
        etBuilder.Property(nameof(VIN)).HasMaxLength(17).IsRequired();

        etBuilder.Link<Truck, Carrier>(nameof(Carrier), Required: true);
        etBuilder.Link<Truck, VehiculeModel>(nameof(Model), Required: true);

        etBuilder.Link<Truck, SCT>(nameof(SCT));
        etBuilder.Link<Truck, Maintenance>(nameof(Maintenance));
        etBuilder.Link<Truck, Insurance>(nameof(Insurance));

    }
}
