using System.ComponentModel.DataAnnotations;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Vehicules.Trucks;

/// <summary>
///     [Entity]
/// </summary>
public class TruckExternal
    : TWSScopeEntity<Truck_Common> {

    #region Properties

    /// <summary>
    ///     External carrier identification.
    /// </summary>
    [StringLength(100, MinimumLength = 1)]
    public string Carrier { get; set; } = string.Empty;

    /// <summary>
    ///     External truck vehicule number identifier.
    /// </summary>
    [StringLength(17, MinimumLength = 1)]
    public string? VIN { get; set; }

    /// <summary>
    ///     External truck usa plate.
    /// </summary>
    [StringLength(7, MinimumLength = 5)]
    public string? UsaPlate { get; set; }

    /// <summary>
    ///     External truck mex plate.
    /// </summary>
    [StringLength(7, MinimumLength = 7)]
    public string? MxPlate { get; set; }

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Trucks_Externals");

        etBuilder.Property(nameof(Carrier)).HasMaxLength(100).IsRequired();

        etBuilder.Property(nameof(VIN)).HasMaxLength(17);
        etBuilder.Property(nameof(UsaPlate)).HasMaxLength(7);
        etBuilder.Property(nameof(MxPlate)).HasMaxLength(7);

    }
}
