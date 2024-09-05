using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Axis
    : BDatabaseSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public string Name { get; set; } = null!;

    public int Quantity { get; set; }

    public string? Description { get; set; }

    public virtual ICollection<TrailerClass> TrailerClasses { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Name), [Required, new LengthValidator(1, 30)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<Axis>(entity => {
            entity.HasKey(e => e.Id);
            entity.ToTable("Axes");

            entity.Property(e => e.Id)
                 .HasColumnName("id");

            entity.Property(e => e.Name)
                .HasMaxLength(30)
                .IsUnicode(false);

            entity.Property(e => e.Description)
                .HasMaxLength(100)
                .IsUnicode(false);

        });
    }
}
