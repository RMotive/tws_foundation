using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class TrailerCommon
    : BBusinessEntity {

    /// <summary>
    ///     Business trailer identifier number.
    /// </summary>
    [StringLength(16, MinimumLength = 1)]
    public string Economic { get; set; } = string.Empty;

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     Desscriptive type.
    /// </summary>
    public TrailerType? Type { get; set; }

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>
    public Situation? Situation { get; set; }

    /// <summary>
    ///     <see cref="Entities.Location"/> information.
    /// </summary>
    public Location? Location { get; set; }



    /// <summary>
    ///     <see cref="Trailer"/> information.
    /// </summary>
    public Trailer? Internal { get; set; }

    /// <summary>
    ///     <see cref="TrailerExternal"/> information.
    /// </summary>
    public TrailerExternal? External { get; set; }

    #region Custom Getters

    /// <summary>
    ///     Gets the [Trailer] carrier name.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> or <see cref="External"/>.
    ///     for <see cref="Internal"/> also needs to be loaded <see cref="Trailer.Carrier"/>.
    /// </remarks>
    public string? Carrier
        => Internal?.Carrier?.Name ?? External?.Carrier;

    /// <summary>
    ///     Gets the [Trailer] mexican plate.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> or <see cref="External"/>.
    ///     for <see cref="Internal"/> also needs loaded <see cref="Trailer.Plates"/>
    /// </remarks>
    public string? PlateMEX
        => Internal?.Plates.LastOrDefault(i => i.Country == "MEX")?.Identifier ?? External?.MxPlate;

    /// <summary>
    ///     Gets the [Trailer] usa plate.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> or <see cref="External"/>
    ///     for <see cref="Internal"/> also needs loaded <see cref="Trailer.Plates"/>
    /// </remarks>
    public string? PlateUSA
        => Internal?.Plates.LastOrDefault(i => i.Country == "USA")?.Identifier ?? External?.UsaPlate;

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
            ..Container,
            (nameof(Economic), [ new LengthValidator(1, 16) ] ),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<TrailerCommon>(
            (etBuilder) => {
                etBuilder.ToTable("Trailers_Commons");

                etBuilder.Property(e => e.Economic).HasMaxLength(16).IsRequired();

                etBuilder.Link<TrailerCommon, Status>(
                        nameof(Status),
                        nameof(Status.Trailers),
                        Required: true,
                        Auto: true
                    );

                etBuilder.Link<TrailerCommon, TrailerType>(nameof(Type), nameof(TrailerType.Trailers));
                etBuilder.Link<TrailerCommon, Situation>(nameof(Situation), nameof(Entities.Situation.Trailers));
                etBuilder.Link<TrailerCommon, Location>(nameof(Location), nameof(Entities.Location.Trailers));
            }
        );
    }
}
