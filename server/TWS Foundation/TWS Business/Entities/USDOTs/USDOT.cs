using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Entities.USDOTs;

public class USDOT
    : BEntity, IHistorical<USDOT_History> {

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
    ///     <see cref="Carrier"/> dependants from this <see cref="USDOT"/>
    /// </summary>
    public virtual ICollection<Carrier> Carriers { get; set; } = [];

    #endregion

    /// <summary>
    ///     History entries.
    /// </summary>
    public ICollection<USDOT_History> History { get; set; } = [];

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(MC)).HasMaxLength(7).IsFixedLength().IsRequired();
        etBuilder.Property(nameof(SCAC)).HasMaxLength(4).IsFixedLength().IsRequired();

        etBuilder.Link<USDOT, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
    }
}
