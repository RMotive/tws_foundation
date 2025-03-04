using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that stores geolocalization information.
/// </summary>
public class Address
    : BBusinessEntity {

    #region Properties

    /// <summary>
    ///     State code.
    /// </summary>
    [StringLength(3, MinimumLength = 2)]
    public string? State { get; set; }

    /// <summary>
    ///     Street identifier.
    /// </summary>
    [StringLength(100, MinimumLength = 1)]
    public string? Street { get; set; }

    /// <summary>
    ///     Alternative street identifier.
    /// </summary>
    /// </summary>
    [StringLength(100, MinimumLength = 1)]
    public string? AltStreet { get; set; }

    /// <summary>
    ///     City code.
    /// </summary>
    [StringLength(30, MinimumLength = 1)]
    public string? City { get; set; }

    /// <summary>
    ///     ZIP code.
    /// </summary>
    [StringLength(5, MinimumLength = 5)]
    public string? ZIP { get; set; }

    /// <summary>
    ///     Country code.
    /// </summary>
    [StringLength(3, MinimumLength = 2)]
    public string Country { get; set; } = null!;

    /// <summary>
    ///     Address subdivision identifier. (Colonia / Neighbourhood)
    /// </summary>
    [StringLength(30, MinimumLength = 1)]
    public string? Subdivision { get; set; }

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Employee"/> dependants from this <see cref="Address"/>.
    /// </summary>
    public ICollection<Employee> Employees { get; set; } = [];

    /// <summary>
    ///     <see cref="Location"/> dependants from this <see cref="Address"/>.
    /// </summary>
    public ICollection<Location> Locations { get; set; } = [];

    /// <summary>
    ///     <see cref="Carrier"/> dependants from this <see cref="Address"/>.
    /// </summary>
    public ICollection<Carrier> Carriers { get; set; } = [];

    /// <summary>
    ///     <see cref="CarrierH"/> dependants from this <see cref="Address"/>.
    /// </summary>
    public ICollection<CarrierH> CarriersHistories { get; set; } = [];

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        LengthValidator streetValidator = new(1, 100, true);
        LengthValidator divisionValidator = new(1, 30, true);

        Container = [
            ..Container,
            ( nameof(State), [ new LengthValidator(2, 3, true) ] ),
            ( nameof(Street), [ streetValidator ] ),
            ( nameof(AltStreet), [ streetValidator ] ),
            ( nameof(City), [ divisionValidator ] ),
            ( nameof(ZIP), [ new LengthValidator(5, 5, true) ] ),
            ( nameof(Country), [ new LengthValidator(2, 3) ] ),
            ( nameof(City), [ divisionValidator ] )
        ];
        return Container;
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {

        etBuilder.Property(nameof(State)).HasMaxLength(3);
        etBuilder.Property(nameof(Street)).HasMaxLength(100);
        etBuilder.Property(nameof(AltStreet)).HasMaxLength(100);
        etBuilder.Property(nameof(City)).HasMaxLength(30);
        etBuilder.Property(nameof(ZIP)).HasMaxLength(5).IsFixedLength();
        etBuilder.Property(nameof(Country)).HasMaxLength(3).IsRequired();
        etBuilder.Property(nameof(Subdivision)).HasMaxLength(30);
    }
}