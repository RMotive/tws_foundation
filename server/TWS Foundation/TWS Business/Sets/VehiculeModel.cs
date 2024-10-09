using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class VehiculeModel
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public int Status { get; set; }

    public string Name { get; set; } = null!;

    public DateOnly Year { get; set; }

    public int Manufacturer {  get; set; }

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

    public static void CreateModel(ModelBuilder Builder) {
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
