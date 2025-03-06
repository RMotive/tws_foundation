using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities;

/// <summary>
///     [etBuilder] that represents an external driver not handled by the business administration, a third party driver.
/// </summary>
public partial class DriverExternal
    : TWSScopeEntity<DriverCommon> {

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Identification"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Identification Identification { get; set; } = default!;

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Drivers_Externals");

        etBuilder.Link<DriverExternal, Identification>(
                nameof(Identification),
                TargetReference: "",
                Required: true,
                Auto: true
            );
    }
}
