using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class SCT
    : BBusinessEntity {

    #region Properties

    /// <summary>
    ///     Type identifier.
    /// </summary>
    [StringLength(6, MinimumLength = 6)]
    public string Type { get; set; } = string.Empty;

    /// <summary>
    ///     Number.
    /// </summary>
    [StringLength(25, MinimumLength = 25)]
    public string Number { get; set; } = string.Empty;

    /// <summary>
    ///     Document configuration.
    /// </summary>
    [StringLength(10, MinimumLength = 6)]
    public string Configuration { get; set; } = string.Empty;

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Truck"/> dependants from this <see cref="SCT"/>
    /// </summary>
    public ICollection<Truck> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer"/> dependants from this <see cref="SCT"/>
    /// </summary>
    public ICollection<Trailer> Trailers { get; set; } = [];

    #endregion


    /// <summary>
    ///     History entries.
    /// </summary>
    public ICollection<SctH> History { get; set; } = [];

    protected override void DesignEntity(ModelBuilder mBuilder) {
        mBuilder.Entity<SCT>(
            (etBuilder) => {

                etBuilder.Property(e => e.Configuration).HasMaxLength(10).IsRequired();
                etBuilder.Property(e => e.Number).HasMaxLength(25).IsRequired();
                etBuilder.Property(e => e.Type).HasMaxLength(6).IsRequired();

                etBuilder.Link<SCT, Status>(
                        nameof(Status),
                        Required: true,
                        Auto: true
                    );
            }
        );
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Type), [Required, new LengthValidator(6,6)]),
            (nameof(Number), [Required, new LengthValidator(25,25)]),
            (nameof(Configuration), [Required, new LengthValidator(6,10)]),

        ];
        return Container;
    }
}
