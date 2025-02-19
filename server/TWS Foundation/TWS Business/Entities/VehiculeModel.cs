using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class VehiculeModel
    : BBusinessDatabaseEntity, IEntity_Name {

    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    public int Status { get; set; }

    public DateOnly Year { get; set; }

    public int Manufacturer { get; set; }

    public virtual Manufacturer? ManufacturerNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<Trailer> Trailers { get; set; } = [];

    public virtual ICollection<Truck> Trucks { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
                .. Container,
            (nameof(Status), [new PointerValidator(true)]),
            (nameof(Name), [new RequiredValidator(), new LengthValidator(Max: 32)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<VehiculeModel>(Entity => {
            Entity.ToTable("Vehicules_Models");
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                 .HasColumnName("id");

            Entity.Property(e => e.Name)
                .HasMaxLength(32)
                .IsUnicode(false);

            Entity.HasOne(d => d.ManufacturerNavigation)
                .WithMany(p => p.Models)
                .HasForeignKey(d => d.Manufacturer)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.VehiculeModels)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
