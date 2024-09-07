using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Manufacturer
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public string Model { get; set; } = null!;

    public string Brand { get; set; } = null!;

    public DateOnly Year { get; set; }

    public virtual ICollection<Truck> Trucks { get; set; } = [];

    public virtual ICollection<Trailer> Trailers { get; set; } = [];

    public virtual ICollection<TruckH> TrucksH { get; set; } = [];

    public static void Set(ModelBuilder builder) {
        builder.Entity<Manufacturer>(entity => {
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Id)
                .HasColumnName("id");

            entity.Property(e => e.Brand)
                .HasMaxLength(15)
                .IsUnicode(false);

            entity.Property(e => e.Model)
                .HasMaxLength(30)
                .IsUnicode(false);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Model), [Required, new LengthValidator(1, 30)]),
            (nameof(Brand), [Required, new LengthValidator(1, 15)]),
            (nameof(Year), [Required]),
        ];

        return Container;
    }
}
