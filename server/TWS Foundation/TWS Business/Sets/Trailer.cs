using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Trailer
    : BSet {
    

    

    public int Status { get; set; }

    public int Common { get; set; }

    public int Carrier { get; set; }

    public int? Model { get; set; }

    public int? Sct { get; set; }

    public int? Maintenance { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Sct? SctNavigation { get; set; }

    public virtual Carrier? CarrierNavigation { get; set; }

    public virtual TrailerCommon? TrailerCommonNavigation { get; set; }

    public virtual VehiculeModel? VehiculesModelsNavigation { get; set; }

    public virtual Maintenance? MaintenanceNavigation { get; set; }

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];

    public virtual ICollection<Plate> Plates { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
                .. Container,
            (nameof(Status), [new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<Trailer>(Entity => {
            Entity.ToTable("Trailers");
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Sct)
              .HasColumnName("SCT");

            Entity.HasOne(d => d.TrailerCommonNavigation)
                .WithMany(p => p.Trailers)
                .HasForeignKey(d => d.Common);

            Entity.HasIndex(e => e.Common)
               .IsUnique();

            Entity.HasOne(d => d.SctNavigation)
             .WithMany(p => p.Trailers)
             .HasForeignKey(d => d.Sct);

            Entity.HasOne(d => d.CarrierNavigation)
                .WithMany(p => p.Trailers)
                .HasForeignKey(d => d.Carrier)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.VehiculesModelsNavigation)
                .WithMany(p => p.Trailers)
                .HasForeignKey(d => d.Model)
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
