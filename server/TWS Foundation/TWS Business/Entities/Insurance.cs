using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class Insurance
    : BBusinessEntity {

    #region Properties

    /// <summary>
    ///     Insurance policy identifier.
    /// </summary>
    [StringLength(20, MinimumLength = 1)]
    public string Policy { get; set; } = string.Empty;

    /// <summary>
    ///     Contract country.
    /// </summary>
    [StringLength(3, MinimumLength = 2)]
    public string Country { get; set; } = string.Empty;

    /// <summary>
    ///     Insurance expiration date.
    /// </summary>
    public DateOnly Expiration { get; set; }

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
    ///     <see cref="Truck"/> dependants from this <see cref="Insurance"/>
    /// </summary>
    public ICollection<Truck> Trucks { get; set; } = [];

    #endregion

    /// <summary>
    ///     History entries.
    /// </summary>
    public ICollection<InsuranceH> History { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Policy), [new UniqueValidator(), new LengthValidator(1, 20),]),
            (nameof(Expiration), [Required, new UniqueValidator()]),
            (nameof(Country), [new LengthValidator(2, 3)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Insurance>(
            (etBuilder) => {
                etBuilder.Property(e => e.Country).HasMaxLength(3);

                etBuilder.Property(e => e.Policy).HasMaxLength(20);

                etBuilder.Link<Insurance, Status>(
                        nameof(Status),
                        Required: true,
                        Auto: true
                    );
            }
        );
    }
}
