using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Carriers;
using TWS_Business.Entities.Maintenances;
using TWS_Business.Entities.Plates;
using TWS_Business.Entities.SCTs;

namespace TWS_Business.Entities.Trailers;

/// <summary>
///     [Entity] for <see cref="Trailer"/> business operations.
/// </summary>
public class Trailer
    : TWSScopeEntity<Trailer_Common> {

    #region Relations

    /// <summary>
    ///     <see cref="SCTs.SCT"/> information.
    /// </summary>
    public SCT? SCT { get; set; }

    /// <summary>
    ///     <see cref="VehiculeModel"/> information.
    /// </summary>
    public VehiculeModel? Model { get; set; }

    /// <summary>
    ///     <see cref="Maintenances.Maintenance"/> information.
    /// </summary>
    public Maintenance? Maintenance { get; set; }

    /// <summary>
    ///     <see cref="Carriers.Carrier"/> information
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Carrier Carrier { get; set; } = default!;

    /// <summary>
    ///     <see cref="Plate"/>s information. 
    /// </summary>
    public ICollection<Plate> Plates { get; set; } = [];

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="YardLog"/>s dependants from this <see cref="Trailer"/>.
    /// </summary>
    public ICollection<YardLog> YardLogs { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Link<Trailer, Carrier>(
                nameof(Carrier),
                Required: true,
                Auto: true
            );

        etBuilder.Link<Trailer, SCT>(nameof(SCT));
        etBuilder.Link<Trailer, VehiculeModel>(nameof(Model));
        etBuilder.Link<Trailer, Maintenance>(nameof(Maintenance));
    }
}
