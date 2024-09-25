using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;
public partial class TruckH
: BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.Now;

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
            ..Container,
            (nameof(Vin), [Unique, new LengthValidator(17, 17)]),
            (nameof(Economic), [new LengthValidator(1, 16)]),
            (nameof(Sequence), [new RequiredValidator()]),
            (nameof(Manufacturer), [Pointer]),
            (nameof(Status), [Pointer]),
            (nameof(Entity), [Pointer])
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<TruckH>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Trucks_H");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Motor)
                .HasMaxLength(16)
                .IsUnicode(false);

            Entity.Property(e => e.Vin)
                .HasMaxLength(17)
                .IsUnicode(false)
                .HasColumnName("VIN");

            Entity.Property(e => e.Economic)
                .HasMaxLength(16)
                .IsUnicode(false);

            Entity.Property(e => e.MaintenanceH)
               .HasColumnName("MaintenanceH");
            Entity.Property(e => e.InsuranceH)
               .HasColumnName("InsuranceH");
            Entity.Property(e => e.CarrierH)
              .HasColumnName("CarrierH");

            Entity.HasOne(d => d.StatusNavigation)
               .WithMany(p => p.TrucksH)
               .HasForeignKey(d => d.Status);

            Entity.HasOne(d => d.TruckNavigation)
               .WithMany(p => p.TrucksH)
               .HasForeignKey(d => d.Entity);

            Entity.HasOne(d => d.CarrierHNavigation)
                 .WithMany(p => p.TrucksH)
                 .HasForeignKey(d => d.CarrierH);

            Entity.HasOne(d => d.ManufacturerNavigation)
                .WithMany(p => p.TrucksH)
                .HasForeignKey(d => d.Manufacturer)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.SituationNavigation)
                .WithMany(p => p.TrucksH)
                .HasForeignKey(d => d.Situation)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.InsuranceHNavigation)
                .WithMany(p => p.TrucksH)
                .HasForeignKey(d => d.InsuranceH);

            Entity.HasOne(d => d.MaintenanceHNavigation)
                .WithMany(p => p.TrucksH)
                .HasForeignKey(d => d.MaintenanceH);
        });
    }
}