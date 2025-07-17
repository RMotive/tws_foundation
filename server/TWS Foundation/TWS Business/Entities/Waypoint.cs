
using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using BEntity = TWS_Business.Bases.BEntity;

namespace TWS_Business.Entities;
/// <summary>
///     Represents a precise physic location based on coordinates parameters, to locate concrete locations or items.
/// </summary>
public class Waypoint
    : BEntity {


    #region Properties

    /// <summary>
    ///     Longitude coordinate.
    /// </summary>
    /// <remarks>
    ///     Location longitude coordinate value.
    /// </remarks>
    [Required]
    public decimal Longitude { get; set; }

    /// <summary>
    ///     Latitude coordinate.
    /// </summary>
    /// <remarks>
    ///     Location latitude coordinate value.
    /// </remarks>
    [Required]
    public decimal Latitude { get; set; }

    /// <summary>
    ///     Altitude coordinate.
    /// </summary>
    /// <remarks>
    ///     Location altitude coordinate value.
    /// </remarks>
    public decimal? Altitude { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Location"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    /// 
    [Relation]
    public Location Location { get; set; } = default!;

    #endregion 

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Longitude)).HasPrecision(9, 6).IsRequired();
        etBuilder.Property(nameof(Latitude)).HasPrecision(9, 6).IsRequired();
        etBuilder.Property(nameof(Altitude)).HasPrecision(9, 6);

        etBuilder.Link<Waypoint, Location>(
                nameof(Location),
                Index: true,
                Required: true,
                Auto: true
            );
    }
}
