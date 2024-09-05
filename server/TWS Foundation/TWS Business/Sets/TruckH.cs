using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;
public partial class TruckH
: BDatabaseSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Sequence { get; set; }

    public int Status { get; set; }

    public int Entity { get; set; }

    public string Vin { get; set; } = null!;

    public string? Motor { get; set; } = null!;

    public string Economic { get; set; } = null!;

    public int Manufacturer { get; set; }

    public int? CarrierH { get; set; }

    public int? Situation { get; set; }

    public int? MaintenanceH { get; set; }

    public int? InsuranceH { get; set; }

    public virtual CarrierH? CarrierHNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Truck? TruckNavigation { get; set; }

    public virtual Situation? SituationNavigation { get; set; }

    public virtual Manufacturer? ManufacturerNavigation { get; set; }

    public virtual InsuranceH? InsuranceHNavigation { get; set; }

    public virtual MaintenanceH? MaintenanceHNavigation { get; set; }



    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        UniqueValidator Unique = new();
        PointerValidator Pointer = new(true);
        Container = [
                .. Container,
            (nameof(Vin), [Unique, new LengthValidator(17, 17)]),
            (nameof(Economic), [new LengthValidator(1, 16)]),
            (nameof(Sequence), [new RequiredValidator()]),
            (nameof(Manufacturer), [Pointer]),
            //(nameof(CarrierH), [Pointer]),
            (nameof(Status), [Pointer]),
            (nameof(Entity), [Pointer])
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<TruckH>(entity => {
            entity.HasKey(e => e.Id);
            entity.ToTable("Trucks_H");

            entity.Property(e => e.Id)
                .HasColumnName("id");

            entity.Property(e => e.Motor)
                .HasMaxLength(16)
                .IsUnicode(false);

            entity.Property(e => e.Vin)
                .HasMaxLength(17)
                .IsUnicode(false)
                .HasColumnName("VIN");

            entity.Property(e => e.Economic)
                .HasMaxLength(16)
                .IsUnicode(false);

            entity.Property(e => e.MaintenanceH)
               .HasColumnName("MaintenanceH");
            entity.Property(e => e.InsuranceH)
               .HasColumnName("InsuranceH");
            entity.Property(e => e.CarrierH)
              .HasColumnName("CarrierH");

            entity.HasOne(d => d.StatusNavigation)
               .WithMany(p => p.TrucksH)
               .HasForeignKey(d => d.Status);

            entity.HasOne(d => d.TruckNavigation)
               .WithMany(p => p.TrucksH)
               .HasForeignKey(d => d.Entity);

            entity.HasOne(d => d.CarrierHNavigation)
                 .WithMany(p => p.TrucksH)
                 .HasForeignKey(d => d.CarrierH);

            entity.HasOne(d => d.ManufacturerNavigation)
                .WithMany(p => p.TrucksH)
                .HasForeignKey(d => d.Manufacturer)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.SituationNavigation)
                .WithMany(p => p.TrucksH)
                .HasForeignKey(d => d.Situation)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.InsuranceHNavigation)
                .WithMany(p => p.TrucksH)
                .HasForeignKey(d => d.InsuranceH);

            entity.HasOne(d => d.MaintenanceHNavigation)
                .WithMany(p => p.TrucksH)
                .HasForeignKey(d => d.MaintenanceH);
        });
    }
}