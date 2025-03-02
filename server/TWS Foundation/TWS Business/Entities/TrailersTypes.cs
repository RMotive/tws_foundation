using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class TrailerType
    : BBusinessEntity {

    #region Properties

    /// <summary>
    ///     Size description.
    /// </summary>
    [StringLength(16)]
    public string Size { get; set; } = string.Empty;

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Class"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public TrailerClass Class { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="TrailerCommon"/> dependants from this <see cref="TrailerType"/>
    /// </summary>
    public ICollection<TrailerCommon> Trailers { get; set; } = [];

    #endregion


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
            ..Container,
            (nameof(Size), [new LengthValidator(Max: 16)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<TrailerType>(
            (etBuilder) => {
                etBuilder.ToTable("Trailers_Types");

                etBuilder.Property(e => e.Size).HasMaxLength(16).IsRequired();

                etBuilder.Link<TrailerType, Status>(
                        nameof(Status),
                        Required: true,
                        Auto: true
                    );
                etBuilder.Link<TrailerType, TrailerClass>(
                        nameof(Class),
                        Required: true,
                        Auto: true
                    );
            }
        );
    }
}
