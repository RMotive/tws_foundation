using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Situation
    : BDatabaseSet {
    public override int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public virtual ICollection<Truck>? Trucks { get; set; } = [];

    public static void Set(ModelBuilder builder) {
        builder.Entity<Situation>(entity => {
            entity.HasKey(e => e.Id);

            entity.HasIndex(e => e.Name)
                .IsUnique();

            entity.Property(e => e.Id);
            entity.Property(e => e.Description)
                .HasMaxLength(100);
            entity.Property(e => e.Name)
                .HasMaxLength(25);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        Container = [
            ..Container,
            (nameof(Name), [Required, new LengthValidator(1, 25)]),
            (nameof(Description), [new LengthValidator(1, 100)]),
        ];
        return Container;
    }
}
