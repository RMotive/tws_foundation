using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class MaintenanceH
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }


    public int Sequence { get; set; }

    public int Status { get; set; }

    public int Entity { get; set; }

    public DateTime Anual { get; set; }

    public DateTime Trimestral { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Maintenance? MaintenanceNavigation { get; set; }

    public virtual ICollection<TruckH> TrucksH { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Anual), [Required]),
            (nameof(Trimestral), [Required]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(Entity), [Required, new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<MaintenanceH>(entity => {
            entity.ToTable("Maintenances_H");
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Id)
                .HasColumnName("id");

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.MaintenancesH)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.MaintenanceNavigation)
                .WithMany(p => p.MaintenancesH)
                .HasForeignKey(d => d.Entity)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
