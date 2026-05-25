using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;
using TWS_Business.Entities.USDOTs;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [History] entity for <see cref="Carrier"/>.
/// </summary>
public class Carrier_History
    : BHistory<Carrier> {

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
    [EntityDependant("Status", typeof(Status))]
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Address"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Address", typeof(Address))]
    public Address Address { get; set; } = default!;

    /// <summary>
    ///     <see cref="Approach_History"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("ApproachHistory", typeof(Approach_History))]
    public Approach_History ApproachHistory { get; set; } = default!;

    /// <summary>
    ///     <see cref="USDOT_History"/> information.
    /// </summary>
    [EntityDependant("USDOTHistory", typeof(USDOT_History))]
    public USDOT_History? USDOTHistory { get; set; }

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Carriers_Histories");

        etBuilder.Link<Carrier_History, Status>(
                nameof(Status),
                targetRef: nameof(Status.CarriersHistories),
                isRequired: true,
                isAutoLoaded: true
            );
        etBuilder.Link<Carrier_History, Approach_History>(
                nameof(ApproachHistory),
                targetRef: nameof(Approach_History.CarriersHistories),
                isRequired: true,
                isAutoLoaded: true
            );
        etBuilder.Link<Carrier_History, Address>(
                nameof(Address),
                targetRef: nameof(Address.CarriersHistories),
                isRequired: true,
                isAutoLoaded: true
            );
        etBuilder.Link<Carrier_History, USDOT_History>(nameof(USDOTHistory), nameof(USDOT_History.CarriersHistories));
    }
}
