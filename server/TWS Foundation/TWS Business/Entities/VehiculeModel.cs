using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Trucks;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that stores information about a vehicule model with its descriptive name and year of manufacturing.
/// </summary>
public class VehiculeModel
    : TWSEntity, IEntity_Name {

    #region Properties

    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }

    /// <summary>
    ///     Manufacturing year.
    /// </summary>
    public DateOnly Year { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Manufacturer"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Manufacturer Manufacturer { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Trailer"/> dependents from this <see cref="VehiculeModel"/>
    /// </summary>
    public ICollection<Trailer> Trailers { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck"/> dependents from this <see cref="VehiculeModel"/>
    /// </summary>
    public ICollection<Truck> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck_History"/> dependants from this <see cref="VehiculeModel"/>.
    /// </summary>
    public ICollection<Truck_History> TrucksHistories { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Vehicule_Models");

        etBuilder.Property(nameof(Year)).HasColumnType("date").IsRequired();

        etBuilder.Link<VehiculeModel, Status>(
                nameof(Status),
                TargetReference: nameof(Entities.Status.Models),
                Required: true,
                Auto: true
            );
        etBuilder.Link<VehiculeModel, Manufacturer>(
                nameof(Manufacturer),
                TargetReference: nameof(Entities.Manufacturer.Models),
                Required: true,
                Auto: true
            );
    }
}
