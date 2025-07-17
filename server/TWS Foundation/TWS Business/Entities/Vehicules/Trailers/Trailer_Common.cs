using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Vehicules.Trailers;

/// <summary>
///     [Entity] that stores common information along Trailers. (<see cref="Trailer"/> / <see cref="TrailerExternal"/>).
/// </summary>
public class Trailer_Common
    : Bases.BCommonEntity<Trailer, TrailerExternal> {

    #region Properties

    /// <summary>
    ///     Business trailer identifier number.
    /// </summary>
    [StringLength(16, MinimumLength = 1)]
    public string Economic { get; set; } = string.Empty;

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
    ///     Desscriptive type.
    /// </summary>    
    [Relation]
    public Trailer_Type? Type { get; set; }

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>    
    [Relation]
    public Situation? Situation { get; set; }

    /// <summary>
    ///     <see cref="Entities.Location"/> information.
    /// </summary>    
    [Relation]
    public Location? Location { get; set; }

    #endregion

    #region Custom Getters

    /// <summary>
    ///     Gets the [Trailer] carrier name.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> or <see cref="External"/>.
    ///     for <see cref="Internal"/> also needs to be loaded <see cref="Trailer.Carrier"/>.
    /// </remarks>
    public string? Carrier
        => Internal?.Carrier?.Name ?? External?.Carrier;

    /// <summary>
    ///     Gets the [Trailer] mexican plate.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> or <see cref="External"/>.
    ///     for <see cref="Internal"/> also needs loaded <see cref="Trailer.Plates"/>
    /// </remarks>
    public string? PlateMEX
        => Internal?.Plates.LastOrDefault(i => i.Country == "MEX")?.Identifier ?? External?.MxPlate;

    /// <summary>
    ///     Gets the [Trailer] usa plate.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> or <see cref="External"/>
    ///     for <see cref="Internal"/> also needs loaded <see cref="Trailer.Plates"/>
    /// </remarks>
    public string? PlateUSA
        => Internal?.Plates.LastOrDefault(i => i.Country == "USA")?.Identifier ?? External?.UsaPlate;

    #endregion

    protected override void DesignCommonEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Trailers_Commons");

        etBuilder.Property(nameof(Economic)).HasMaxLength(16).IsRequired();

        etBuilder.Link<Trailer_Common, Status>(
                nameof(Status),
                nameof(Status.Trailers),
                Required: true,
                Auto: true
            );

        etBuilder.Link<Trailer_Common, Trailer_Type>(nameof(Type), nameof(Trailer_Type.Trailers));
        etBuilder.Link<Trailer_Common, Situation>(nameof(Situation), nameof(Entities.Situation.Trailers));
        etBuilder.Link<Trailer_Common, Location>(nameof(Location), nameof(Entities.Location.Trailers));
    }
}
