using System.Reflection;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace TWS_Business.Entities;

public partial class Truck
    : BBusinessDatabaseEntity {    

    public int Status { get; set; }

    public int Common { get; set; }

    public string? Motor { get; set; }

    public string Vin { get; set; } = null!;

    public int Carrier { get; set; }

    public int Model { get; set; }

    public int? Sct { get; set; }

    public int? Maintenance { get; set; }

    public int? Insurance { get; set; }

    public Carrier? CarrierNavigation { get; set; }

    public TruckCommon? TruckCommonNavigation { get; set; }

    public Sct? SctNavigation { get; set; }

    public Insurance? InsuranceNavigation { get; set; }

    public Maintenance? MaintenanceNavigation { get; set; }
        
    public VehiculeModel? VehiculeModelNavigation { get; set; }

    public Status? StatusNavigation { get; set; }

    public ICollection<Plate> Plates { get; set; } = [];

    public ICollection<YardLog> YardLogs { get; set; } = [];

    public ICollection<TruckH> TrucksH { get; set; } = [];

    public ICollection<PlateH> PlatesH { get; set; } = [];

    public ICollection<TruckInventory> TrucksInventories { get; set; } = [];

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<Truck>(Entity => {

            Entity
                .HasIndex(e => e.Common)
                .IsUnique();

            Entity
                .Property(e => e.Motor)
                .HasMaxLength(16)
                .IsUnicode(false);

            Entity.Property(e => e.Sct)
                .HasColumnName("SCT");

            Entity.HasOne(d => d.CarrierNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Carrier)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.SctNavigation)
              .WithMany(p => p.Trucks)
              .HasForeignKey(d => d.Sct);

            Entity.HasOne(d => d.InsuranceNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Insurance);

            Entity.HasOne(d => d.MaintenanceNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Maintenance);

            Entity.HasOne(d => d.VehiculeModelNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Model)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.TruckCommonNavigation)
                .WithMany(p => p.Trucks)
                .HasForeignKey(d => d.Common);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator required = new();
        Container = [
            ..Container,
            (nameof(Status), [new PointerValidator(true)]),
            (nameof(Vin), [required, new UniqueValidator(), new LengthValidator(Min: 1, Max: 17)]),
        ];
        return Container;
    }
}
