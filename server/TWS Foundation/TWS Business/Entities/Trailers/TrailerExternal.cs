using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Trailers;

/// <summary>
///     [Entity] that stores information about not business managed trailers, are external trailers with minimal control.
/// </summary>
public class TrailerExternal
    : TWSScopeEntity<Trailer_Common> {

    #region Properties

    /// <summary>
    ///     External carrier identification
    /// </summary>
    [StringLength(100, MinimumLength = 1)]
    public string Carrier { get; set; } = string.Empty;

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
            (nameof(Carrier), [ new LengthValidator(1, 100) ] ),
            (nameof(UsaPlate), [ new LengthValidator(5, 7, true) ] ),
            (nameof(MxPlate), [ new LengthValidator(7, 7, true) ] )
        ];
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Trailers_Externals");

        etBuilder.Property(nameof(Carrier)).HasMaxLength(100).IsRequired();
        etBuilder.Property(nameof(UsaPlate)).HasMaxLength(7);
        etBuilder.Property(nameof(MxPlate)).HasMaxLength(7);
    }
}
