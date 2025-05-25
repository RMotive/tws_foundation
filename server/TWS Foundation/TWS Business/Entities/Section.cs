using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that stores information about a physical vehicules storage section.
/// </summary>
public class Section
    : BEntity, INamedEntity {

    #region Properties
    [StringLength(100, MinimumLength = 1)]
    public string Name { get; set; } = string.Empty;

    [StringLength(200, MinimumLength = 1)]
    public string? Description { get; set; } = string.Empty;

    /// <summary>
    ///     Total physical capacity.
    /// </summary>
    public int Capacity { get; set; }

    /// <summary>
    ///     Current physical capacity utilization.
    /// </summary>
    public int Ocupancy { get; set; }

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
    ///     <see cref="Location"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Location Yard { get; set; } = default!;

    #endregion

    #region Dependats 

    /// <summary>
    ///     <see cref="YardLog"/> dependants from this <see cref="Section"/>
    /// </summary>
    public ICollection<YardLog> YardLogs { get; set; } = [];

    #endregion

    #region Custom Getters

    /// <summary>
    ///     Gets a parsed displayable name.
    /// </summary>
    /// <remarks>
    ///     Needs laoded <see cref="Location"/>.
    /// </remarks>
    public string? Display
        => $"{Yard?.Name} - {Name}";

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Capacity)).IsRequired();
        etBuilder.Property(nameof(Ocupancy)).IsRequired();

        etBuilder.Link<Section, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Section, Location>(
                nameof(Yard),
                Required: true,
                Auto: true
            );
    }
}
