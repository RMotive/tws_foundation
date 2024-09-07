using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Situation
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public virtual ICollection<DriverCommon>? DriversCommons { get; set; } = [];

    public virtual ICollection<TruckCommon>? TrucksCommons { get; set; } = [];

    public virtual ICollection<TrailerCommon>? TrailersCommons { get; set; } = [];

    public virtual ICollection<TruckH> TrucksH { get; set; } = [];

    public static void Set(ModelBuilder builder) {
        builder.Entity<Situation>(entity => {
            entity.HasKey(e => e.Id);

            entity.HasIndex(e => e.Name)
                .IsUnique();

            entity.Property(e => e.Id)
                .HasColumnName("id");
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
        ];
        return Container;
    }
}
