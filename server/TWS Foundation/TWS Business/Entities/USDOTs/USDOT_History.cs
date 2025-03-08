using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Entities.USDOTs;

/// <summary>
///     [Entity] TODO: Define purpose
/// </summary>
public class USDOT_History
    : TWSHistory<USDOT> {

    #region Properties

    /// <summary>
    ///     todo: to be defined
    /// </summary>
    [StringLength(7, MinimumLength = 7)]
    public string MC { get; set; } = string.Empty;

    /// <summary>
    ///     TODO: to be defined
    /// </summary>
    [StringLength(4, MinimumLength = 4)]
    public string SCAC { get; set; } = string.Empty;

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

    #region Dependants

    /// <summary>
    ///     <see cref="Carrier_History"/> dependants from this <see cref="USDOT_History"/>.
    /// </summary>
    public ICollection<Carrier_History> CarriersHistories { get; set; } = [];

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            ( nameof(MC), [ new LengthValidator(7, 7) ]),
            ( nameof(SCAC), [ new LengthValidator(4, 4) ]),
        ];
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(MC)).HasMaxLength(7).IsFixedLength().IsRequired();
        etBuilder.Property(nameof(SCAC)).HasMaxLength(4).IsFixedLength().IsRequired();

        etBuilder.Link<USDOT_History, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
    }
}
