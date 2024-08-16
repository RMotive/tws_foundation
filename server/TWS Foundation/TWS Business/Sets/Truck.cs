using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Truck
    : BDatabaseSet {
    public override int Id { get; set; }

    public string Vin { get; set; } = null!;

    public int Manufacturer { get; set; }

    public string Motor { get; set; } = null!;

    public int? Sct { get; set; }

    public int? Maintenance { get; set; }

    public int? Situation { get; set; }

    public int? Insurance { get; set; }

    public virtual Insurance? InsuranceNavigation { get; set; }

    public virtual Maintenance? MaintenanceNavigation { get; set; }

    public virtual Manufacturer? ManufacturerNavigation { get; set; }

    public virtual Sct? SctNavigation { get; set; }

    public virtual Situation? SituationNavigation { get; set; }

    public virtual ICollection<Plate> Plates { get; set; } = [];

    public static void Set(ModelBuilder builder) {
        builder.Entity<Truck>(entity => {
            entity.HasKey(e => e.Id);

            entity.HasIndex(e => e.Vin).IsUnique();
            entity.HasIndex(e => e.Motor).IsUnique();

            entity.Property(e => e.Id);
            entity.Property(e => e.Motor)
                .HasMaxLength(16)
                .IsUnicode(false);
            entity.Property(e => e.Sct);
            entity.Property(e => e.Vin)
                .HasMaxLength(17)
                .IsUnicode(false);

            entity.HasOne(d => d.InsuranceNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Insurance);

            entity.HasOne(d => d.MaintenanceNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Maintenance);
            entity.HasOne(d => d.ManufacturerNavigation).WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Manufacturer)
                .OnDelete(DeleteBehavior.ClientSetNull);
            entity.HasOne(d => d.SctNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Sct);
            entity.HasOne(d => d.SituationNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Situation);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        UniqueValidator Unique = new();
        Container = [
            ..Container,
            (nameof(Vin), [Unique, new LengthValidator(17, 17)]),
            (nameof(Motor), [Unique, new LengthValidator(15, 16)]),

        ];
        return Container;
    }
}
