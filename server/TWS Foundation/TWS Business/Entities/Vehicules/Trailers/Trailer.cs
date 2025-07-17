using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;
using TWS_Business.Entities.Maintenances;

namespace TWS_Business.Entities.Vehicules.Trailers;

/// <summary>
///     [Entity] for <see cref="Trailer"/> business operations.
/// </summary>
public class Trailer
    : BCommonScopeEntity<Trailer_Common> {

    #region Relations

    /// <summary>
    ///     <see cref="Vehicules.SCT"/> information.
    /// </summary>
    [Relation]
    public SCT? SCT { get; set; }

    /// <summary>
    ///     <see cref="VehiculeModel"/> information.
    /// </summary>
    [Relation]
    public VehiculeModel? Model { get; set; }

    /// <summary>
    ///     <see cref="Maintenances.Maintenance"/> information.
    /// </summary>
    [Relation]
    public Maintenance? Maintenance { get; set; }

    /// <summary>
    ///     <see cref="Vehicules.Carrier"/> information
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Carrier Carrier { get; set; } = default!;

    /// <summary>
    ///     <see cref="Plate"/>s information. 
    /// </summary>
    [Relation]
    public ICollection<Plate> Plates { get; set; } = [];

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="YardLog"/>s dependants from this <see cref="Trailer"/>.
    /// </summary>
    public ICollection<YardLog> YardLogs { get; set; } = [];

    #endregion

    protected override void DesignCommonScopeEntity(EntityTypeBuilder etBuilder) {
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
