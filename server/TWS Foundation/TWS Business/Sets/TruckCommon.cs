using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class TruckCommon
    : BDatabaseSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public string Vin { get; set; } = null!;

    public string Economic { get; set; } = null!;

    public int? Location { get; set; }

    public int? Situation { get; set; }

    public virtual Situation? SituationNavigation { get; set; }

    public virtual Location? LocationNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<Truck> Trucks { get; set; } = [];

    public virtual ICollection<TruckExternal> TrucksExternals { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        UniqueValidator Unique = new();

        Container = [
                .. Container,
            (nameof(Vin), [Unique, new LengthValidator(17, 17)]),
            (nameof(Economic), [Required, new LengthValidator(1, 16)]),
            (nameof(Status), [new PointerValidator(true)])
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<TruckCommon>(entity => {
            entity.ToTable("Trucks_Commons");
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Id)
                 .HasColumnName("id");

            entity.Property(e => e.Vin)
               .HasMaxLength(17)
               .IsUnicode(false)
               .HasColumnName("VIN");

            entity.Property(e => e.Economic)
                .HasMaxLength(16)
                .IsUnicode(false);

            entity.HasOne(d => d.SituationNavigation)
               .WithMany(p => p.TrucksCommons)
               .HasForeignKey(d => d.Situation);

            entity.HasOne(d => d.LocationNavigation)
               .WithMany(p => p.TrucksCommons)
               .HasForeignKey(d => d.Location)
               .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.StatusNavigation)
               .WithMany(p => p.TrucksCommons)
               .HasForeignKey(d => d.Status)
               .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
