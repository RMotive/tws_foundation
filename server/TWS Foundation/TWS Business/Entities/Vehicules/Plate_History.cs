using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [History Entity] for <see cref="Plate"/>
/// </summary>
public class Plate_History
    : TWSHistory<Plate> {

    #region Properties

    /// <summary>
    ///     Plate identifier number.
    /// </summary>
    public string Identifier { get; set; } = string.Empty;

    /// <summary>
    ///     Political country the plate is from.
    /// </summary>
    [StringLength(3, MinimumLength = 2)]
    public string Country { get; set; } = string.Empty;

    /// <summary>
    ///     Political state name the plate is from.
    /// </summary>
    [StringLength(3, MinimumLength = 2)]
    public string? State { get; set; }

    /// <summary>
    ///     Expiration date.
    /// </summary>
    public DateOnly? Expiration { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    #endregion


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            ( nameof(Identifier), [ new LengthValidator(5, 12) ] ),
            ( nameof(Country), [ new LengthValidator(2, 3) ] ),
            ( nameof(State), [ new LengthValidator(2, 3, true) ] )
        ];
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(State)).HasMaxLength(3);
        etBuilder.Property(nameof(Country)).HasMaxLength(3);
        etBuilder.Property(nameof(Identifier)).HasMaxLength(12);

        etBuilder.Link<Plate_History, Status>(
                nameof(Status),
                TargetReference: nameof(Status.PlatesHistories),
                Required: true,
                Auto: true
            );
    }
}
