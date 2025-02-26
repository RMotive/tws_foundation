using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] for <see cref="Trailer"/> business operations.
/// </summary>
public class Trailer
    : BBusinessEntity<TrailerCommon> {

    /// <summary>
    ///     <see cref="Entities.SCT"/> information.
    /// </summary>
    public SCT? SCT { get; set; }

    /// <summary>
    ///     <see cref="VehiculeModel"/> information.
    /// </summary>
    public VehiculeModel? Model { get; set; }

    /// <summary>
    ///     <see cref="Entities.Maintenance"/> information.
    /// </summary>
    public Maintenance? Maintenance { get; set; }

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Carrier"/> information
    /// </summary>
    public Carrier Carrier { get; set; } = default!;

    /// <summary>
    ///     <see cref="YardLog"/>s entries referencing this <see cref="Trailer"/>.
    /// </summary>
    public ICollection<YardLog> YardLogs { get; set; } = [];

    /// <summary>
    ///     <see cref="Plate"/>s entries referencing this <see cref="Trailer"/>
    /// </summary>
    public ICollection<Plate> Plates { get; set; } = [];

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Trailer>(
            (etBuilder) => {

                etBuilder.LinkMany<Trailer, Status>(nameof(Status), true);
                etBuilder.LinkMany<Trailer, Carrier>(nameof(Carrier), true);

                etBuilder.LinkMany<Trailer, SCT>(nameof(SCT));
                etBuilder.LinkMany<Trailer, VehiculeModel>(nameof(Model));
                etBuilder.LinkMany<Trailer, Maintenance>(nameof(Maintenance));
            }
        );
    }
}
