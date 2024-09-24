using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Trailer
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public int Common { get; set; }

    public int Carrier { get; set; }

    public int Manufacturer { get; set; }

    public int? Maintenance { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Carrier? CarrierNavigation { get; set; }

    public virtual TrailerCommon? TrailerCommonNavigation { get; set; }

    public virtual Manufacturer? ManufacturerNavigation { get; set; }

    public virtual Maintenance? MaintenanceNavigation { get; set; }

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];

    public virtual ICollection<Plate> Plates { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        PointerValidator pointer = new(true);
        Container = [
                .. Container,
            (nameof(Manufacturer), [Required, pointer]),
            (nameof(Common), [Required, pointer]),
            (nameof(Carrier), [new PointerValidator(true)]),
            (nameof(Status), [Required, pointer]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Trailer>(Entity => {
            Entity.ToTable("Trailers");
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.HasOne(d => d.TrailerCommonNavigation)
                .WithMany(p => p.Trailers)
                .HasForeignKey(d => d.Common);

            Entity.HasOne(d => d.CarrierNavigation)
                .WithMany(p => p.Trailers)
                .HasForeignKey(d => d.Carrier)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.ManufacturerNavigation)
                .WithMany(p => p.Trailers)
                .HasForeignKey(d => d.Manufacturer)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.MaintenanceNavigation)
                .WithMany(p => p.Trailers)
                .HasForeignKey(d => d.Maintenance);

            Entity.HasOne(d => d.StatusNavigation)
               .WithMany(p => p.Trailers)
               .HasForeignKey(d => d.Status)
               .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
