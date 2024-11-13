using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Plate
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public int Status { get; set; }

    public string Identifier { get; set; } = null!;

    public string? State { get; set; }

    public string Country { get; set; } = null!;

    public DateOnly? Expiration { get; set; }

    public int? Truck { get; set; }

    public int? Trailer { get; set; }

    public virtual Truck? TruckNavigation { get; set; }

    public virtual Trailer? TrailerNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<PlateH> PlatesH { get; set; } = [];

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Plate>(Entity => {
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");
            Entity.Property(e => e.Country)
                .HasMaxLength(3)
                .IsUnicode(false);
            Entity.Property(e => e.Identifier)
                .HasMaxLength(12)
                .IsUnicode(false);
            Entity.Property(e => e.State)
                .HasMaxLength(3)
                .IsUnicode(false);

            Entity.HasOne(d => d.TruckNavigation)
                .WithMany(p => p.Plates)
                .HasForeignKey(d => d.Truck)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.TrailerNavigation)
                .WithMany(p => p.Plates)
                .HasForeignKey(d => d.Trailer)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Plates)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Identifier), [new LengthValidator(5, 12)]),
            (nameof(Country), [new LengthValidator(2, 3)]),
            (nameof(Status), [new PointerValidator(true)]),
        ];
        return Container;
    }
}
