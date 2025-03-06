using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Trucks;

/// <summary>
///     [Entity] that stores information about not business managed trucks, are external trucks with minimal control.
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
    [StringLength(17, MinimumLength = 17)]
    public string? VIN { get; set; }

    /// <summary>
    ///     Mexican plate number.
    /// </summary>
    [StringLength(7, MinimumLength = 7)]
    public string? MxPlate { get; set; }

    /// <summary>
    ///     USA Plate number.
    /// </summary>
    [StringLength(7, MinimumLength = 5)]
    public string? UsaPlate { get; set; }

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            ( nameof(Carrier), [ new LengthValidator(1, 100) ] ),
            ( nameof(UsaPlate), [ new LengthValidator(5, 7, true) ] ),
            ( nameof(VIN), [ new LengthValidator(17, 17, true) ] ),
            ( nameof(MxPlate), [ new LengthValidator(7, 7, true) ] )
        ];
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Trucks_Externals");

        etBuilder.Property(nameof(Carrier)).HasMaxLength(100).IsRequired();
        etBuilder.Property(nameof(VIN)).HasMaxLength(17).IsFixedLength();

        etBuilder.Property(nameof(UsaPlate)).HasMaxLength(7);
        etBuilder.Property(nameof(MxPlate)).HasMaxLength(7);
    }
}
