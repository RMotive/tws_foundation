using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class TrailerExternal
    : BBusinessEntity<TrailerCommon> {

    /// <summary>
    ///     Carrier idenfitication.
    /// </summary>
    [StringLength(100, MinimumLength = 1)]
    public string Carrier { get; set; } = string.Empty;

    /// <summary>
    ///     Mexican plate number.
    /// </summary>
    public string? MxPlate { get; set; }

    /// <summary>
    ///     USA Plate number.
    /// </summary>
    public string? UsaPlate { get; set; }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        LengthValidator plateValidator = new(12, 12, true);

        Container = [
            ..Container,
            (nameof(Carrier), [new LengthValidator(1, 100)]),
            (nameof(UsaPlate), [ plateValidator ] ),
            (nameof(MxPlate), [ plateValidator ] )
        ];

        return Container;
    }

    protected override void DesignEntity(ModelBuilder mBuilder) {
        mBuilder.Entity<TrailerExternal>(
            (etBuilder) => {
                etBuilder.ToTable("Trailers_Externals");

                etBuilder.Property(e => e.Carrier).HasMaxLength(100).IsRequired();
                etBuilder.Property(e => e.UsaPlate).HasMaxLength(12);
                etBuilder.Property(e => e.MxPlate).HasMaxLength(12);
            }
        );
    }
}
