using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity_H] History entry for <see cref="Truck"/> Entity.
/// </summary>
public class TruckH
: BBusinessEntity {

    /// <summary>
    ///     History entry sequence.
    /// </summary>
    public int Sequence { get; set; }

    /// <summary>
    ///     Vehicule Identifier Number.
    /// </summary>
    [StringLength(17, MinimumLength = 17)]
    public string VIN { get; set; } = string.Empty;

    /// <summary>
    ///     Internal business vehicule identifier.
    /// </summary>
    [StringLength(16, MinimumLength = 1)]
    public string Economic { get; set; } = string.Empty;

    /// <summary>
    ///     Unique motor identifier.
    /// </summary>
    [StringLength(16)]
    public string? Motor { get; set; }

    /// <summary>
    ///     <see cref="Truck"/> [Entity] source.
    /// </summary>
    public Truck Entity { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Manufacturer"/>
    /// </summary>
    public Manufacturer Manufacturer { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.CarrierH"/> Carrier history entry.
    /// </summary>
    public CarrierH? CarrierH { get; set; }

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>
    public Situation? Situation { get; set; }

    /// <summary>
    ///     <see cref="Entities.MaintenanceH"/> history information.
    /// </summary>
    public MaintenanceH? MaintenanceH { get; set; }

    /// <summary>
    ///     <see cref="Entities.InsuranceH"/> history information
    /// </summary>
    public InsuranceH? InsuranceH { get; set; }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        UniqueValidator Unique = new();

        Container = [
            ..Container,
            (nameof(VIN), [Unique, new LengthValidator(17, 17)]),
            (nameof(Economic), [new LengthValidator(1, 16)]),
            (nameof(Sequence), [new RequiredValidator()]),
        ];

        return Container;
    }

    protected override void DesignEntity(ModelBuilder mBuilder) {
        mBuilder.Entity(
                (EntityTypeBuilder<TruckH> etBuilder) => {
                    etBuilder.Property(th => th.Sequence).IsRequired();

                    etBuilder.Link<TruckH, Truck>(nameof(Entity), Required: true);
                    etBuilder.HasIndex("EntityShadow", nameof(Sequence)).IsUnique();

                    etBuilder.Property(tH => tH.VIN).HasMaxLength(17).IsRequired();
                    etBuilder.Property(tH => tH.Economic).HasMaxLength(16).IsRequired();

                    etBuilder.Property(tH => tH.Motor).HasMaxLength(16);
                    etBuilder.Link<TruckH, Status>(nameof(Status), Required: true);
                    etBuilder.Link<TruckH, Manufacturer>(nameof(Manufacturer), Required: true);

                    etBuilder.Link<TruckH, CarrierH>(nameof(CarrierH));
                    etBuilder.Link<TruckH, Situation>(nameof(Situation));
                    etBuilder.Link<TruckH, InsuranceH>(nameof(InsuranceH));
                    etBuilder.Link<TruckH, MaintenanceH>(nameof(MaintenanceH));
                }
            );
    }
}