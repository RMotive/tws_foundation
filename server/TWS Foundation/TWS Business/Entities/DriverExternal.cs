using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class DriverExternal
    : BBusinessEntity {

    /// <summary>
    ///     <see cref="DriverCommon"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public DriverCommon Common { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Identification"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Identification Identification { get; set; } = default!;

    protected override void DesignEntity(ModelBuilder Builder) {
        Builder.Entity<DriverExternal>(
            (Entity) => {
                Entity.ToTable("Drivers_Externals");

                Entity.Link<DriverExternal, DriverCommon>(
                        nameof(Common),
                        TargetReference: nameof(DriverCommon.External),
                        Required: true,
                        Auto: true
                    );
                Entity.Link<DriverExternal, Identification>(
                        nameof(Identification),
                        TargetReference: "",
                        Required: true,
                        Auto: true
                    );
            }
        );
    }
}
