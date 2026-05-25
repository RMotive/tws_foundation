using CSM_Foundation.Database;
using CSM_Database_Core.Core.Attributes;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;
using CSM_Database_Core.Core.Extensions;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that stores information about a physical vehicules storage section.
/// </summary>
public class Section
    : BNamedEntity {

    #region Properties

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
    [EntityDependant("Status", typeof(Status))]
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Location"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Yard", typeof(Location))]
    public Location Yard { get; set; } = default!;

    /// <summary>
    ///     <see cref="Resource"/> Section image information.
    /// </summary>
    [EntityDependant("Resource", typeof(Resource))]
    public Resource? Resource { get; set; }

    #endregion

    #region Dependats 

    /// <summary>
    ///     <see cref="YardLog"/> dependants from this <see cref="Section"/>
    /// </summary>
    [EntityDependency("YardLogs", typeof(YardLog), isCollection:true)]
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
                isRequired: true,
                isAutoLoaded: true
            );
        etBuilder.Link<Section, Location>(
                nameof(Yard),
                isRequired: true,
                isAutoLoaded: true
            );
        etBuilder.Link<Section, Resource>(nameof(Resource));

    }
}
