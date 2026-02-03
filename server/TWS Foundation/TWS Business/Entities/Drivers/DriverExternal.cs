using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;

namespace TWS_Business.Entities.Drivers;

/// <summary>
///     [etBuilder] that represents an external driver not handled by the business administration, a third party driver.
/// </summary>
public partial class DriverExternal
    : BCommonScopeEntity<Driver_Common> {

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Identification"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityRelation]
    public Identification Identification { get; set; } = default!;

    #endregion

    protected override void DesignScopeEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Drivers_Externals");
        etBuilder.Link<DriverExternal, Identification>(
                nameof(Identification),
                TargetReference: "",
                Required: true,
                Auto: true
            );
    }
}
