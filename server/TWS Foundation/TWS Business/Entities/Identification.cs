using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class Identification
    : BBusinessEntity {

    #region Properties

    /// <summary>
    ///     Legal name. 
    /// </summary>
    /// <remarks>
    ///     For more than one name split with space.
    /// </remarks>
    [StringLength(32, MinimumLength = 1)]
    public string Name { get; set; } = string.Empty;

    /// <summary>
    ///     Legal first last name (father).
    /// </summary>
    /// </remarks>
    [StringLength(32, MinimumLength = 1)]
    public string FatherLastname { get; set; } = string.Empty;

    /// <summary>
    ///     Legal second last name (mother).
    /// </summary>
    /// </remarks>
    [StringLength(32, MinimumLength = 1)]
    public string MotherLastName { get; set; } = string.Empty;

    /// <summary>
    ///     Birthday.
    /// </summary>
    public DateOnly? Birthday { get; set; }

    #endregion

    #region Status

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    #endregion

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Identification>(
            (etBuilder) => {
                etBuilder.Property(e => e.FatherLastname).HasMaxLength(32).IsRequired();
                etBuilder.Property(e => e.MotherLastName).HasMaxLength(32).IsRequired();
                etBuilder.Property(i => i.Name).HasMaxLength(32).IsRequired();

                etBuilder.Link<Identification, Status>(
                        nameof(Status),
                        Required: true,
                        Auto: true
                    );
            }
        );
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        LengthValidator nameValidator = new(1, 32);

        Container = [
            ..Container,
            (nameof(Name), [ nameValidator ] ),
            (nameof(FatherLastname), [ nameValidator ] ),
            (nameof(MotherLastName), [ nameValidator ] ),
        ];
        return Container;
    }
}
