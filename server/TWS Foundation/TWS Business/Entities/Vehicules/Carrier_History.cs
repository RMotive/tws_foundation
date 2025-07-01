using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.USDOTs;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [History] entity for <see cref="Carrier"/>.
/// </summary>
public class Carrier_History
    : TWSHistory<Carrier> {

    #region Properties
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Address"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Address Address { get; set; } = default!;

    /// <summary>
    ///     <see cref="Approach_History"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Approach_History ApproachHistory { get; set; } = default!;

    /// <summary>
    ///     <see cref="USDOT_History"/> information.
    /// </summary>
    public USDOT_History? USDOTHistory { get; set; }

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Carriers_Histories");

        etBuilder.Link<Carrier_History, Status>(
                nameof(Status),
                TargetReference: nameof(Status.CarriersHistories),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Carrier_History, Approach_History>(
                nameof(ApproachHistory),
                TargetReference: nameof(Approach_History.CarriersHistories),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Carrier_History, Address>(
                nameof(Address),
                TargetReference: nameof(Address.CarriersHistories),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Carrier_History, USDOT_History>(nameof(USDOTHistory), nameof(USDOT_History.CarriersHistories));
    }
}
