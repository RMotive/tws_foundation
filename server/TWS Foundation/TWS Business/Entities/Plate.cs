using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class Plate
    : BBusinessEntity {

    #region Properties

    /// <summary>
    ///     Plate identifier number.
    /// </summary>
    public string Identifier { get; set; } = string.Empty;

    /// <summary>
    ///     Political country the plate is from.
    /// </summary>
    [StringLength(3, MinimumLength = 2)]
    public string Country { get; set; } = string.Empty;

    /// <summary>
    ///     Political state name the plate is from.
    /// </summary>
    [StringLength(3, MinimumLength = 2)]
    public string? State { get; set; }

    /// <summary>
    ///     Expiration date.
    /// </summary>
    public DateOnly? Expiration { get; set; }

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
    ///     <see cref="Entities.Truck"/> information.
    /// </summary>
    public Truck? Truck { get; set; }

    /// <summary>
    ///     <see cref="Entities.Trailer"/> information.
    /// </summary>
    public Trailer? Trailer { get; set; }

    #endregion

    /// <summary>
    ///     etBuilder history entries.
    /// </summary>
    public ICollection<PlateH> History { get; set; } = [];

    protected override void DesignEntity(ModelBuilder mBuilder) {
        mBuilder.Entity<Plate>(
            (etBuilder)=> {
                etBuilder.Property(e => e.Country).HasMaxLength(3);
                etBuilder.Property(e => e.Identifier).HasMaxLength(12);
                etBuilder.Property(e => e.State).HasMaxLength(3);

                etBuilder.Link<Plate, Status>(
                        nameof(Status),
                        Required: true,
                        Auto: true
                    );
            }
        );
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Identifier), [new LengthValidator(5, 12)]),
            (nameof(Country), [new LengthValidator(2, 3)]),
        ];
        return Container;
    }
}
