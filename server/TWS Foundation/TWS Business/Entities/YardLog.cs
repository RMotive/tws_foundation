using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Trucks;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] for <see cref="YardLog"/> entries. A <see cref="YardLog"/> record stores information about an entry or exit from the main business [Yards].
/// </summary>
public class YardLog
    : TWSEntity {

    #region Properties

    /// <summary>
    ///     Wheter the record is entry or exit.
    /// </summary>
    public bool Entry { get; set; }

    /// <summary>
    ///     <see cref="YardLog"/> record load seal.
    /// </summary>
    [StringLength(64, MinimumLength = 10)]
    public string? Seal { get; set; }

    /// <summary>
    ///     <see cref="YardLog"/> record load alternative seal.
    /// </summary>
    [StringLength(64, MinimumLength = 10)]
    public string? SealAlt { get; set; }

    /// <summary>
    ///     From where the trip started - where is going.
    /// </summary>
    [StringLength(100, MinimumLength = 10)]
    public string FromTo { get; set; } = string.Empty;

    /// <summary>
    ///     <see cref="YardLog"/> record evidence photo.
    /// </summary>
    public byte[] Evidence { get; set; } = [];

    /// <summary>
    ///     <see cref="YardLog"/> damage evidence photo.
    /// </summary>
    public byte[]? Damage { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.LoadType"/> information.
    /// </summary>
    public LoadType LoadType { get; set; } = default!;

    /// <summary>
    ///     <see cref="Employee"/> guard information.
    /// </summary>
    public Employee Guard { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Section"/> information.
    /// </summary>
    public Section Section { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.DriverCommon"/> information.
    /// </summary>
    public DriverCommon Driver { get; set; } = default!;

    /// <summary>
    ///     <see cref="Trucks.Truck_Common"/> information.
    /// </summary>
    public Truck_Common Truck { get; set; } = default!;

    /// <summary>
    ///     <see cref="Trailers.Trailer_Common"/> information.
    /// </summary>
    public Trailer_Common? Trailer { get; set; }

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Yard_Logs");

        etBuilder.Property(nameof(Seal)).HasMaxLength(64);
        etBuilder.Property(nameof(SealAlt)).HasMaxLength(64);
        etBuilder.Property(nameof(FromTo)).HasMaxLength(100).IsRequired();
        etBuilder.Property(nameof(Evidence)).IsRequired();
        etBuilder.Property(nameof(Damage));

        etBuilder.Link<YardLog, LoadType>(nameof(LoadType), Required: true);
        etBuilder.Link<YardLog, Employee>(nameof(Guard), Required: true);
        etBuilder.Link<YardLog, Section>(nameof(Section), Required: true);
        etBuilder.Link<YardLog, DriverCommon>(nameof(Driver), Required: true);
        etBuilder.Link<YardLog, Truck_Common>(nameof(Truck), Required: true);
        etBuilder.Link<YardLog, Trailer_Common>(nameof(Trailer));
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        LengthValidator sealLengthValidation = new(10, 64, true);

        return [
            ..Container,
            (nameof(Seal), [ sealLengthValidation ]),
            (nameof(SealAlt), [ sealLengthValidation ]),
            (nameof(FromTo), [ new LengthValidator(10, 100) ]),
            (nameof(Evidence), [ new LengthValidator(32) ]),
            (nameof(Damage), [ new LengthValidator(32, AllowNull: true) ]),
        ];
    }
}
