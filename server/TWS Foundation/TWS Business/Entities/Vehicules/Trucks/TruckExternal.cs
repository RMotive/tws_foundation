using System.ComponentModel.DataAnnotations;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;

namespace TWS_Business.Entities.Vehicules.Trucks;

/// <summary>
///     {entity} class.
///     
///     Represents an external business truck usually from partners that needs to be loaded into own systems 
///     for entry control or movement calulations.
/// </summary>
public class TruckExternal
    : BCommonScopeEntity<Truck_Common> {

    #region Properties

    /// <summary>
    ///     Carrier identification.
    /// </summary>
    [StringLength(100, MinimumLength = 1)]
    public string Carrier { get; set; } = string.Empty;

    /// <summary>
    ///     Vehicule identifier number.
    /// </summary>
    [StringLength(17, MinimumLength = 1)]
    public string? VIN { get; set; }

    /// <summary>
    ///     USA Plate.
    /// </summary>
    [StringLength(7, MinimumLength = 5)]
    public string? UsaPlate { get; set; }

    /// <summary>
    ///     MX Plate.
    /// </summary>
    [StringLength(7, MinimumLength = 7)]
    public string? MxPlate { get; set; }

    #endregion

    protected override void DesignScopeEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Trucks_Externals");

        etBuilder.Property(nameof(Carrier)).HasMaxLength(100).IsRequired();

        etBuilder.Property(nameof(VIN)).HasMaxLength(17);
        etBuilder.Property(nameof(UsaPlate)).HasMaxLength(7);
        etBuilder.Property(nameof(MxPlate)).HasMaxLength(7);

    }
}
