using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] for <see cref="YardLog"/> entries. A <see cref="YardLog"/> record stores information about an entry or exit from the main business [Yards].
/// </summary>
public class YardLog
    : BBusinessEntity {

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
    ///     <see cref="Entities.TruckCommon"/> information.
    /// </summary>
    public TruckCommon Truck { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.TrailerCommon"/> information.
    /// </summary>
    public TrailerCommon? Trailer { get; set; }

    protected override void DesignEntity(ModelBuilder Builder) {
        Builder.Entity<YardLog>(entity => {
            entity.ToTable(
                "Yard_Logs",
                (tb) => tb.HasTrigger("YardLogs_InsertInto_TrucksInventories")
            );


            entity.Property(e => e.Seal).HasMaxLength(64);
            entity.Property(e => e.SealAlt).HasMaxLength(64);
            entity.Property(e => e.FromTo).HasMaxLength(100).IsRequired();
            entity.Property(y => y.Evidence).IsRequired();
            entity.Property(y => y.Damage);

            entity.Link<YardLog, LoadType>(nameof(LoadType), Required: true);
            entity.Link<YardLog, Employee>(nameof(Guard), Required: true);
            entity.Link<YardLog, Section>(nameof(Section), Required: true);
            entity.Link<YardLog, DriverCommon>(nameof(Driver), Required: true);
            entity.Link<YardLog, TruckCommon>(nameof(Truck), Required: true);
            entity.Link<YardLog, TrailerCommon>(nameof(Trailer));
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        LengthValidator sealLengthValidation = new(10, 64, true);

        Container = [
            ..Container,
            (nameof(Seal), [ sealLengthValidation ]),
            (nameof(SealAlt), [ sealLengthValidation ]),
            (nameof(FromTo), [ new LengthValidator(10, 100) ]),
            (nameof(Evidence), [ new LengthValidator(32) ]),
            (nameof(Damage), [ new LengthValidator(32, AllowNull: true) ]),
        ];

        return Container;
    }
}
