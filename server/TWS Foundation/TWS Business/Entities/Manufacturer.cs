using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class Manufacturer
    : BBusinessEntity, IEntity_Name {

    public string Name { get; set; } = default!;

    public string? Description { get; set; }

    /// <summary>
    ///     <see cref="TruckH"/> entries referencing this <see cref="Manufacturer"/>
    /// </summary>
    public ICollection<TruckH> TrucksHistories { get; set; } = [];

    public ICollection<VehiculeModel> Models { get; set; } = [];

    protected override void DesignEntity(ModelBuilder Builder) {
        Builder.Entity<Manufacturer>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Manufacturers");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Name)
                .HasMaxLength(32)
                .IsUnicode(false);

            Entity.Property(e => e.Description)
                .HasMaxLength(100)
                .IsUnicode(false);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Name), [Required, new LengthValidator(Max: 32)]),
        ];

        return Container;
    }
}
