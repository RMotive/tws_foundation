using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

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
    [EntityRelation]
    public SCT? SCT { get; set; }

    /// <summary>
    ///     <see cref="VehiculeModel"/> information.
    /// </summary>
    [EntityRelation]
    public VehiculeModel? Model { get; set; }

    /// <summary>
    ///     <see cref="Maintenances.Maintenance"/> information.
    /// </summary>
    [EntityRelation]
    public Maintenance? Maintenance { get; set; }

    /// <summary>
    ///     <see cref="Vehicules.Carrier"/> information
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityRelation]
    public Carrier Carrier { get; set; } = default!;

    /// <summary>
    ///     <see cref="Plate"/>s information. 
    /// </summary>
    [EntityRelation]
    public ICollection<Plate> Plates { get; set; } = [];

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="YardLog"/>s dependants from this <see cref="Trailer"/>.
    /// </summary>
    public ICollection<YardLog> YardLogs { get; set; } = [];

    #endregion

    protected override void DesignScopeEntity(EntityTypeBuilder etBuilder) {
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
