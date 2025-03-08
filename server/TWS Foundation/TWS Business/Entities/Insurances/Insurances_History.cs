using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Entities.Insurances;

/// <summary>
///     [History Entity] for <see cref="Insurance"/>
/// </summary>
public class Insurance_History
    : TWSHistory<Insurance> {

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
    ///     <see cref="Truck_History"/> history entries referencing this <see cref="Insurance_History"/>.
    /// </summary>
    public ICollection<Truck_History> TrucksHistories { get; set; } = [];

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        return [
            ..Container,
            (nameof(Policy), [new UniqueValidator(), new LengthValidator(1, 20),]),
            (nameof(Expiration), [Required, new UniqueValidator()]),
            (nameof(Country), [new LengthValidator(2, 3)]),
        ];
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Country)).HasMaxLength(3);
        etBuilder.Property(nameof(Policy)).HasMaxLength(20);

        etBuilder.Link<Insurance_History, Status>(
                nameof(Status),
                TargetReference: nameof(Entities.Status.InsurancesHistories),
                Required: true,
                Auto: true
            );
    }
}
