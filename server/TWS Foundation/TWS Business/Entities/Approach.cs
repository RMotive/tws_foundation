using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] Stores contact information for business purposes.
/// </summary>
public class Approach
    : BEntity, IHistorical<Approach_History> {

    #region Properties

    /// <summary>
    ///     Electronic mail address.
    /// </summary>
    [StringLength(64)]
    public string? EMail { get; set; } = string.Empty;

    /// <summary>
    ///     Enterprise phone number.
    /// </summary>
    [StringLength(13)]
    public string? Enterprise { get; set; }

    /// <summary>
    ///     Personal phone number.
    /// </summary>
    [StringLength(13)]
    public string? Personal { get; set; }

    /// <summary>
    ///     Alternative phone number
    /// </summary>
    [StringLength(13)]
    public string? Alternative { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Carrier"/> dependants from this <see cref="Approach"/>
    /// </summary>
    public virtual ICollection<Carrier> Carriers { get; set; } = [];

    /// <summary>
    ///     <see cref="Employee"/> dependants from this <see cref="Approach"/>
    /// </summary>
    public virtual ICollection<Employee> Employees { get; set; } = [];

    #endregion

    /// <summary>
    ///     History entries.
    /// </summary>
    public ICollection<Approach_History> History { get; set; } = [];

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Approaches");

        etBuilder.Property(nameof(EMail)).HasMaxLength(64).IsRequired();
        etBuilder.Property(nameof(Enterprise)).HasMaxLength(13);
        etBuilder.Property(nameof(Personal)).HasMaxLength(13);
        etBuilder.Property(nameof(Alternative)).HasMaxLength(30);

        etBuilder.Link<Approach, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
    }
}
