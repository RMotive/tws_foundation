using CSM_Foundation.Database;
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that represents a physical <see cref="Truck"/> for business operations.
/// </summary>
public class Truck
    : BBusinessEntity<TruckCommon> {

    /// <summary>
    ///     Motor identifier.
    /// </summary>
    public string? Motor { get; set; }

    /// <summary>
    ///     Vehicule identifier number.
    /// </summary>
    public string VIN { get; set; } = string.Empty;

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Carrier"/> information.
    /// </summary>
    public Carrier Carrier { get; set; } = default!;

    /// <summary>
    ///     <see cref="VehiculeModel"/> information.
    /// </summary>
    public VehiculeModel Model { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.SCT"/> information.
    /// </summary>
    public SCT? SCT { get; set; }

    /// <summary>
    ///     <see cref="Entities.Maintenance"/> information.
    /// </summary>
    public Maintenance? Maintenance { get; set; }

    /// <summary>
    ///     <see cref="Entities.Insurance"/> information.
    /// </summary>
    public Insurance? Insurance { get; set; }


    /// <summary>
    ///     <see cref="Plate"/>s referencing this <see cref="Truck"/>.
    /// </summary>
    public ICollection<Plate>? Plates { get; set; } = [];

    /// <summary>
    ///     <see cref="YardLog"/>s referencing this <see cref="Truck"/>
    /// </summary>
    public ICollection<YardLog> YardLogs { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck"/> history entries.
    /// </summary>
    public ICollection<TruckH> History { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator required = new();
        Container = [
            ..Container,
            (nameof(VIN), [required, new UniqueValidator(), new LengthValidator(Min: 1, Max: 17)]),
        ];
        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Truck>(
                (etBuilder) => {
                    etBuilder.Property(t => t.Motor).HasMaxLength(16);
                    etBuilder.Property(t => t.VIN).HasMaxLength(17).IsRequired();

                    etBuilder.LinkMany<Truck, Status>(nameof(Status), true);
                    etBuilder.LinkMany<Truck, Carrier>(nameof(Carrier), true);
                    etBuilder.LinkMany<Truck, VehiculeModel>(nameof(Model), true);

                    etBuilder.LinkMany<Truck, SCT>(nameof(SCT));
                    etBuilder.LinkMany<Truck, Maintenance>(nameof(Maintenance));
                }
        );
    }
}
