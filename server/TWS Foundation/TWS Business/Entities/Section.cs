using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class Section
    : BBusinessEntity, IEntity_Name {

    /// <summary>
    ///     etBuilder name.
    /// </summary>
    [StringLength(1, MinimumLength = 32)]
    public string Name { get; set; } = string.Empty;

    /// <summary>
    ///     etBuilder description.
    /// </summary>
    public string? Description { get; set; } = string.Empty;

    /// <summary>
    ///     Total physical capacity.
    /// </summary>
    public int Capacity { get; set; }

    /// <summary>
    ///     Current physical capacity utilization.
    /// </summary>
    public int Ocupancy { get; set; }

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Location"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Location Yard { get; set; } = default!;


    /// <summary>
    ///     <see cref="YardLog"/> entries referencing this <see cref="Section"/>
    /// </summary>
    public ICollection<YardLog> YardLogs { get; set; } = [];


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

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
            ..Container,
            (nameof(Name), [new LengthValidator(1, 32)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Section>(
            (etBuilder) => {
                etBuilder.HasKey(e => e.Id);

                etBuilder.Property(s => s.Capacity).IsRequired();
                etBuilder.Property(s => s.Ocupancy).IsRequired();

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
        );
    }
}
