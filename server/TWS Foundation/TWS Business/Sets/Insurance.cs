using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Insurance
    : BDatabaseSet {
    public override int Id { get; set; }

    public string Policy { get; set; } = null!;

    public DateOnly Expiration { get; set; }

    public string Country { get; set; } = null!;

    public virtual ICollection<Truck> Trucks { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Policy), [new UniqueValidator(), new LengthValidator(1, 20),]),
            (nameof(Expiration), [Required, new UniqueValidator()]),
            (nameof(Country), [new LengthValidator(2, 3)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        _ = builder.Entity<Insurance>(entity => {
            _ = entity.HasKey(e => e.Id);

            _ = entity.Property(e => e.Id);

            _ = entity.Property(e => e.Country)
                .HasMaxLength(3)
                .IsUnicode(false);

            _ = entity.Property(e => e.Policy)
                .HasMaxLength(20)
                .IsUnicode(false);
        });
    }
}
