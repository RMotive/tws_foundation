using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that stores information about the current situation for a business process entity.
/// </summary>
public class Situation
    : CatalogEntity {

    #region Dependants

    /// <summary>
    ///     <see cref="Driver_Common"/> dependants from this <see cref="Situation"/>
    /// </summary>
    public ICollection<Driver_Common> Drivers { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck_Common"/> dependants form this <see cref="Situation"/>.
    /// </summary>
    public ICollection<Truck_Common> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer_Common"/> dependants from this <see cref="Situation"/>.
    /// </summary>
    public ICollection<Trailer_Common> Trailers { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Reference)).HasMaxLength(8).IsRequired().IsFixedLength();
        etBuilder.HasIndex(nameof(Reference)).IsUnique();
    }
}
