using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Manufacturer
    : BSet {
    

    

    public string? Description { get; set; }

    public virtual ICollection<VehiculeModel> Models { get; set; } = [];

    protected override void DescribeSet(ModelBuilder Builder) {
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
