using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class Maintenance
    : BBusinessEntity {

    #region Properties

    /// <summary>
    ///     Next anual maintenance scheduled.
    /// </summary>
    public DateOnly Anual { get; set; }

    /// <summary>
    ///     Next trimestral maintenance scheduled.
    /// </summary>
    public DateOnly Trimestral { get; set; }

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
    ///     <see cref="Trailer"/> dependants from this <see cref="Maintenance"/>
    /// </summary>
    public ICollection<Trailer> Trailers { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck"/> dependants from this <see cref="Maintenance"/>
    /// </summary>
    public ICollection<Truck> Trucks { get; set; } = [];

    #endregion

    /// <summary>
    ///     History entries.
    /// </summary>
    public ICollection<MaintenanceH> History { get; set; } = [];


    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Maintenance>(
            (etBuilder) => {
                etBuilder.Property(m => m.Anual).IsRequired();
                etBuilder.Property(m => m.Trimestral).IsRequired();

                etBuilder.Link<Maintenance, Status>(
                        nameof(Status),
                        Required: true,
                        Auto: true
                    );
            }
        );
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Anual), [Required]),
            (nameof(Trimestral), [Required]),
            (nameof(Status), [Required, new PointerValidator(true)]),
        ];
        return Container;
    }
}
