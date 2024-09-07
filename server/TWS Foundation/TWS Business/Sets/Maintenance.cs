using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Maintenance
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public DateOnly Anual { get; set; }

    public DateOnly Trimestral { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<Trailer> Trailers { get; set; } = [];

    public virtual ICollection<Truck> Trucks { get; set; } = [];

    public virtual ICollection<MaintenanceH> MaintenancesH { get; set; } = [];


    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Maintenance>(Entity => {
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Maintenances)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Anual), [Required]),
            (nameof(Trimestral), [Required]),
            (nameof(Status), [Required, new PointerValidator(true)]),
        ];
        return Container;
    }
}
