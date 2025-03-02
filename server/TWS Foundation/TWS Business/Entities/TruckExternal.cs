using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class TruckExternal
    : BBusinessEntity<TruckCommon> {

    /// <summary>
    ///     External truck vehicule number identifier.
    /// </summary>
    [StringLength(17)]
    public string? VIN { get; set; }

    /// <summary>
    ///     External truck usa plate.
    /// </summary>
    [StringLength(12)]
    public string? UsaPlate { get; set; }

    /// <summary>
    ///     External truck mex plate.
    /// </summary>
    [StringLength(12)]
    public string? MxPlate { get; set; }

    /// <summary>
    ///     External carrier identification.
    /// </summary>
    [StringLength(100, MinimumLength = 1)]
    public string Carrier { get; set; } = string.Empty;

    protected override void DesignEntity(ModelBuilder Builder) {
        Builder.Entity<TruckExternal>(
            (Entity) => {
                Entity.ToTable("Trucks_Externals");

                Entity.Property(e => e.VIN).HasMaxLength(17);
                Entity.Property(e => e.UsaPlate).HasMaxLength(12);
                Entity.Property(e => e.MxPlate).HasMaxLength(12);

                Entity.Property(e => e.Carrier).HasMaxLength(100).IsRequired();
            }
        );
    }
}
