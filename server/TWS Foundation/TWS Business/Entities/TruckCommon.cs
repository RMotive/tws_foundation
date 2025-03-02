using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class TruckCommon
    : BBusinessEntity {

    /// <summary>
    ///     Business economic identifier.
    /// </summary>
    [StringLength(16, MinimumLength = 1)]
    public string Economic { get; set; } = null!;

    /// <summary>
    ///     <see cref="Entities.Location"/> information.
    /// </summary>
    public Location? Location { get; set; }

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>
    public Situation? Situation { get; set; }

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Truck"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Truck? Internal { get; set; }

    /// <summary>
    ///     <see cref="TruckExternal"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto Included relation.
    /// </remarks>
    public TruckExternal? External { get; set; }

    #region Custom Getters

    /// <summary>
    ///     Gets the [Truck] mexican plate.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> or <see cref="External"/>.
    ///     for <see cref="Internal"/> also needs loaded <see cref="Truck.Plates"/>
    /// </remarks>
    public string? PlateMEX
        => Internal?.Plates?.LastOrDefault(i => i.Country == "MEX")?.Identifier ?? External?.MxPlate;

    /// <summary>
    ///     Gets the [Truck] usa plate.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> or <see cref="External"/>
    ///     for <see cref="Internal"/> also needs loaded <see cref="Truck.Plates"/>
    /// </remarks>
    public string? PlateUSA
        => Internal?.Plates?.LastOrDefault(i => i.Country == "USA")?.Identifier ?? External?.UsaPlate;

    #endregion

    protected override void DesignEntity(ModelBuilder Builder) {
        Builder.Entity<TruckCommon>(Entity => {

            Entity.Property(e => e.Economic).HasMaxLength(16).IsRequired();

            Entity.Link<TruckCommon, Location>(
                    nameof(Location), 
                    TargetReference: nameof(Entities.Location.Trucks)
                );
            Entity.Link<TruckCommon, Situation>(
                    nameof(Situation),
                    TargetReference: nameof(Entities.Situation.Trucks)
                );

            Entity.Link<TruckCommon, Status>(
                    nameof(Status),
                    TargetReference: nameof(Entities.Status.Trucks),
                    Required: true, 
                    Auto: true
                );
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Economic), [Required, new LengthValidator(1, 16)]),
        ];

        return Container;
    }
}
