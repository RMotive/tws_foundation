using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class Carrier
    : BBusinessDatabaseEntity, IEntity_Name {

    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Approach"/> information.
    /// </summary>
    public Approach Approach { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Address"/> information.
    /// </summary>
    public Address Address { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.USDOT"/> information.
    /// </summary>
    public USDOT? USDOT { get; set; }


    /// <summary>
    ///     <see cref="Truck"/>s referencing this <see cref="Carrier"/>
    /// </summary>
    public ICollection<Truck> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer"/>s referencing this <see cref="Carrier"/>. 
    /// </summary>
    public ICollection<Trailer> Trailers { get; set; } = [];

    /// <summary>
    ///     The <see cref="Carrier"/> history entries.
    /// </summary>
    public ICollection<CarrierH> Histories { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator required = new();
        Container = [
            ..Container,
            (nameof(Name), [required, new LengthValidator(Max: 100)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Carrier>(
            (etBuilder) => {

                etBuilder.Property<long>("StatusShadow").HasColumnName("Status").IsRequired();
                etBuilder
                    .HasOne(d => d.Status)
                    .WithMany(p => p.Carriers)
                    .HasForeignKey("StatusShadow")
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Cascade);

                etBuilder.Property<long>("ApproachShadow").HasColumnName("Approach").IsRequired();
                etBuilder
                    .HasOne(d => d.Approach)
                    .WithMany(p => p.Carriers)
                    .HasForeignKey("ApproachShadow")
                    .OnDelete(DeleteBehavior.Cascade);

                etBuilder.Property<long>("AddressShadow").HasColumnName("Address").IsRequired();
                etBuilder
                    .HasOne(c => c.Address)
                    .WithMany(a => a.Carriers)
                    .HasForeignKey("AddressShadow")
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Cascade);

                etBuilder.Property<long?>("USDOTShadow").HasColumnName("USDOT");
                etBuilder
                    .HasOne(c => c.USDOT)
                    .WithMany(u => u.Carriers)
                    .HasForeignKey("USDOTShadow")
                    .OnDelete(DeleteBehavior.Cascade);
            }
        );
    }
}
