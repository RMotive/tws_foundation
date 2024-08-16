using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Sct
    : BDatabaseSet {
    public override int Id { get; set; }

    public string Type { get; set; } = null!;

    public string Number { get; set; } = null!;

    public string Configuration { get; set; } = null!;

    public virtual ICollection<Truck> Trucks { get; set; } = [];

    public static void Set(ModelBuilder builder) {
        builder.Entity<Sct>(entity => {
            entity.HasKey(e => e.Id);


            entity.Property(e => e.Id);
            entity.Property(e => e.Configuration)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.Number)
                .HasMaxLength(25)
                .IsUnicode(false);
            entity.Property(e => e.Type)
                .HasMaxLength(6)
                .IsUnicode(false);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        Container = [
            ..Container,
            (nameof(Type), [Required, new LengthValidator(6,6)]),
            (nameof(Number), [Required, new LengthValidator(25,25)]),
            (nameof(Configuration), [Required, new LengthValidator(6,10)]),
        ];
        return Container;
    }
}
