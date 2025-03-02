using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class VehiculeModel
    : BBusinessEntity, IEntity_Name {

    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }

    /// <summary>
    ///     Manufacturing year.
    /// </summary>
    public DateOnly Year { get; set; }

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Manufacturer"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Manufacturer Manufacturer { get; set; } = default!;


    /// <summary>
    ///     <see cref="Trailer"/> dependents from this <see cref="VehiculeModel"/>
    /// </summary>
    public ICollection<Trailer> Trailers { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck"/> dependents from this <see cref="VehiculeModel"/>
    /// </summary>
    public ICollection<Truck> Trucks { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<VehiculeModel>(
            (etBuilder) => {
                etBuilder.ToTable("Vehicules_Models");

                etBuilder.Property(vm => vm.Year).IsRequired();

                etBuilder.Link<VehiculeModel, Status>(
                        nameof(Status),
                        Required: true,
                        Auto: true
                    );
                etBuilder.Link<VehiculeModel, Manufacturer>(
                        nameof(Manufacturer),
                        TargetReference: nameof(Manufacturer.Models),
                        Required: true,
                        Auto: true
                    );
            }
        );
    }
}
