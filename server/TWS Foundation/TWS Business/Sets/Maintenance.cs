using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Maintenance
    : BDatabaseSet {
    public override int Id { get; set; }

    public DateOnly Anual { get; set; }

    public DateOnly Trimestral { get; set; }

    public virtual ICollection<Truck> Trucks { get; set; } = [];

    public static void Set(ModelBuilder builder) {
        builder.Entity<Maintenance>(entity => {
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Id);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Anual), [Required]),
            (nameof(Trimestral), [Required]),
        ];
        return Container;
    }
}
