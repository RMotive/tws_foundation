using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public class USDOT
    : BBusinessEntity {

    #region Properties

    /// <summary>
    ///     todo: to be defined
    /// </summary>
    [StringLength(7, MinimumLength = 7)]
    public string MC { get; set; } = string.Empty;

    /// <summary>
    ///     TODO: to be defined
    /// </summary>
    [StringLength(4, MinimumLength = 4)]
    public string SCAC { get; set; } = string.Empty;

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
    ///     <see cref="Carrier"/> dependants from this <see cref="USDOT"/>
    /// </summary>
    public virtual ICollection<Carrier> Carriers { get; set; } = [];

    #endregion

    /// <summary>
    ///     History entries.
    /// </summary>
    public ICollection<UsdotH> History { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(MC), [Required, new LengthValidator(7, 7)]),
            (nameof(SCAC), [Required, new LengthValidator(4, 4)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<USDOT>(
            (etBuilder) => {
                etBuilder.Property(e => e.MC).HasMaxLength(7).IsRequired();
                etBuilder.Property(e => e.SCAC).HasMaxLength(4).IsRequired();

                etBuilder.Link<USDOT, Status>(
                        nameof(Status),
                        Required: true,
                        Auto: true
                    );
            }
        );
    }
}
