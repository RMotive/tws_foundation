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

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Situation>(Entity => {
            Entity.HasKey(e => e.Id);


            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.HasIndex(e => e.Name)
                .IsUnique();

            Entity.Property(e => e.Id)
                .HasColumnName("id");
            Entity.Property(e => e.Description)
                .HasMaxLength(100);
            Entity.Property(e => e.Name)
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
