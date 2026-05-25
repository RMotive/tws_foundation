using System.ComponentModel.DataAnnotations;

using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [History Entity] for <see cref="SCT"/>
/// </summary>
public class SCT_History
    : BHistory<SCT> {

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
    [EntityDependant("Status", typeof(Status))]
    public Status Status { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Carrier_History"/> dependants from this <see cref="SCT_History"/>.
    /// </summary>
    [EntityDependency("CarriersH", typeof(Carrier_History), isCollection:true)]
    public ICollection<Carrier_History> CarriersH { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Configuration)).HasMaxLength(10).IsRequired();
        etBuilder.Property(nameof(Number)).HasMaxLength(25).IsRequired();
        etBuilder.Property(nameof(Type)).HasMaxLength(6).IsRequired();

        etBuilder.Link<SCT, Status>(
                nameof(Status),
                isRequired: true,
                isAutoLoaded: true
            );
    }
}
