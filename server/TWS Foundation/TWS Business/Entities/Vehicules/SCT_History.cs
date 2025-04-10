using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validations;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [History Entity] for <see cref="SCT"/>
/// </summary>
public class SCT_History
    : TWSHistory<SCT> {

    #region Properties

    /// <summary>
    ///     Type identifier.
    /// </summary>
    [StringLength(6, MinimumLength = 6)]
    public string Type { get; set; } = string.Empty;

    /// <summary>
    ///     Number.
    /// </summary>
    [StringLength(25, MinimumLength = 25)]
    public string Number { get; set; } = string.Empty;

    /// <summary>
    ///     Document configuration.
    /// </summary>
    [StringLength(10, MinimumLength = 6)]
    public string Configuration { get; set; } = string.Empty;

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
    ///     <see cref="Carrier_History"/> dependants from this <see cref="SCT_History"/>.
    /// </summary>
    public ICollection<Carrier_History> CarriersH { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Configuration)).HasMaxLength(10).IsRequired();
        etBuilder.Property(nameof(Number)).HasMaxLength(25).IsRequired();
        etBuilder.Property(nameof(Type)).HasMaxLength(6).IsRequired();

        etBuilder.Link<SCT, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
    }
}
