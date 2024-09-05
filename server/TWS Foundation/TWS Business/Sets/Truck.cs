using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Truck
    : BDatabaseSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public int Common { get; set; }

    public string Motor { get; set; } = null!;

    public int Carrier { get; set; }

    public int Manufacturer { get; set; }


    public int? Maintenance { get; set; }

    public int? Insurance { get; set; }

    public virtual Carrier? CarrierNavigation { get; set; }

    public virtual TruckCommon? TruckCommonNavigation { get; set; }

    public virtual Insurance? InsuranceNavigation { get; set; }

    public virtual Maintenance? MaintenanceNavigation { get; set; }

    public virtual Manufacturer? ManufacturerNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<Plate> Plates { get; set; } = [];

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];

    public virtual ICollection<TruckH> TrucksH { get; set; } = [];

    public virtual ICollection<PlateH> PlatesH { get; set; } = [];

    public static void Set(ModelBuilder builder) {
        builder.Entity<Truck>(entity => {
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Id)
                .HasColumnName("id");

            entity.Property(e => e.Motor)
                .HasMaxLength(16)
                .IsUnicode(false);

            entity.HasOne(d => d.CarrierNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Carrier)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.InsuranceNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Insurance);

            entity.HasOne(d => d.MaintenanceNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Maintenance);

            entity.HasOne(d => d.ManufacturerNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Manufacturer)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.TruckCommonNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Common);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Status), [new PointerValidator(true)]),
            (nameof(Motor), [new LengthValidator(1, 16)]),
            (nameof(Carrier), [new PointerValidator(true)]),
            (nameof(Manufacturer), [new PointerValidator(true)]),
        ];
        return Container;
    }
}
