using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public class Location
    : BBusinessEntity, IEntity_Name {

    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Address"/> information.
    /// </summary>
    public Address Address { get; set; } = default!;


    /// <summary>
    ///     <see cref="Section"/>s referencing this <see cref="Location"/>
    /// </summary>
    public ICollection<Section> Sections { get; set; } = [];

    /// <summary>
    ///     <see cref="TruckCommon"/>s referencing this <see cref="Location"/>
    /// </summary>
    public ICollection<TruckCommon> TrucksCommons { get; set; } = [];

    /// <summary>
    ///     <see cref="TrailerCommon"/>s referencing this <see cref="Location"/>
    /// </summary>
    public ICollection<TrailerCommon> TrailersCommons { get; set; } = [];



    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Name), [Required, new LengthValidator(1, 30)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Location>(
            (etBuilder) => {

                etBuilder.Property<long>("StatusShadow").HasColumnName("Status").IsRequired();
                etBuilder
                    .HasOne(l => l.Status)
                    .WithMany(s => s.Locations)
                    .HasForeignKey("StatusShadow")
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Cascade);

                etBuilder.Property<long>("AddressShadow").HasColumnName("Address").IsRequired();
                etBuilder
                    .HasOne(l => l.Address)
                    .WithMany(a => a.Locations)
                    .HasForeignKey("AddressShadow")
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Cascade);
            }
        );
    }
}
