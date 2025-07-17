using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Vehicules.Trailers;

/// <summary>
///     [Entity] that stores information about trailer and specifies a category type.
/// </summary>
public class Trailer_Type
    : BEntity {

    #region Properties

    /// <summary>
    ///     Size description.
    /// </summary>
    [StringLength(16)]
    public string Size { get; set; } = string.Empty;

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Class"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Trailer_Class Class { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Trailer_Common"/> dependants from this <see cref="Trailer_Type"/>
    /// </summary>
    public ICollection<Trailer_Common> Trailers { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Trailer_Types");

        etBuilder.Property(nameof(Size)).HasMaxLength(16).IsRequired();

        etBuilder.Link<Trailer_Type, Status>(
                nameof(Status),
                TargetReference: nameof(Status.TrailerTypes),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Trailer_Type, Trailer_Class>(
                nameof(Class),
                TargetReference: nameof(Trailer_Class.TrailerTypes),
                Required: true,
                Auto: true
            );
    }
}
