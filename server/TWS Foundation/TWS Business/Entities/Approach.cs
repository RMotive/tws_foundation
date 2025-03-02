using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Entities;

public partial class Approach
    : BBusinessEntity {

    #region Properties

    /// <summary>
    ///     Electronic mail address.
    /// </summary>
    [StringLength(64)]
    public string Email { get; set; } = string.Empty;

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
    [StringLength(30)]
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
    public ICollection<ApproachesH> History { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
            ..Container,
            (nameof(Email), [new RequiredValidator(), new LengthValidator(Max: 64)]),
            (nameof(Status), [new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Approach>(
            (etBuilder) => {

                etBuilder.Property(e => e.Email).HasMaxLength(64).IsRequired();
                etBuilder.Property(e => e.Enterprise).HasMaxLength(13);
                etBuilder.Property(e => e.Personal).HasMaxLength(13);
                etBuilder.Property(e => e.Alternative).HasMaxLength(30);

                etBuilder.Link<Approach, Status>(
                        nameof(Status),
                        Required: true,
                        Auto: true
                    );
            }
        );
    }
}
