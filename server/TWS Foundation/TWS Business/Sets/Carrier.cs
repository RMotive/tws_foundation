using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Carrier
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public string Name { get; set; } = null!;

    public int Approach { get; set; }

    public int Address { get; set; }

    public int? Usdot { get; set; }

    public int? Sct { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Approach? ApproachNavigation { get; set; }

    public virtual Address? AddressNavigation { get; set; }

    public virtual Usdot? UsdotNavigation { get; set; }

    public virtual Sct? SctNavigation { get; set; }

    public virtual ICollection<Truck> Trucks { get; set; } = [];

    public virtual ICollection<Trailer> Trailers { get; set; } = [];

    public virtual ICollection<CarrierH> CarriersH { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Name), [Required, new LengthValidator(1, 20)]),
            (nameof(Approach), [Required, new PointerValidator(true)]),
            (nameof(Address), [Required, new PointerValidator(true)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Carrier>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Carriers");

            Entity.Property(e => e.Id)
                 .HasColumnName("id");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Name)
                .HasMaxLength(20)
                .IsUnicode(false);

            Entity.HasOne(d => d.ApproachNavigation)
              .WithMany(p => p.Carriers)
              .HasForeignKey(d => d.Approach);

            Entity.HasOne(d => d.AddressNavigation)
                .WithMany(p => p.Carriers)
                .HasForeignKey(d => d.Address)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.Property(e => e.Usdot)
                .HasColumnName("USDOT");
            Entity.HasOne(d => d.UsdotNavigation)
               .WithMany(p => p.Carriers)
               .HasForeignKey(d => d.Usdot);

            Entity.Property(e => e.Sct)
                .HasColumnName("SCT");
            Entity.HasOne(d => d.SctNavigation)
               .WithMany(p => p.Carriers)
               .HasForeignKey(d => d.Sct);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Carriers)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
