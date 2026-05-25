using System.ComponentModel.DataAnnotations;

using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

using BEntity = TWS_Business.Bases.BEntity;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [Entity] TODO: Define purpose.
/// </summary>
public class SCT
    : BEntity {

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
    [EntityDependant]
    public Status Status { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Truck"/> dependants from this <see cref="SCT"/>
    /// </summary>
    [EntityDependency("Trucks", typeof(Truck), isCollection:true)]
    public ICollection<Truck> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer"/> dependants from this <see cref="SCT"/>
    /// </summary>
    [EntityDependency("Trailers", typeof(Trailer), isCollection:true)]
    public ICollection<Trailer> Trailers { get; set; } = [];

    #endregion

    /// <summary>
    ///     History entries.
    /// </summary>
    [EntityDependency("History", typeof(SCT_History), isCollection:true)]
    public ICollection<SCT_History> History { get; set; } = [];

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
