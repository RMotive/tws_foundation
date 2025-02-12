using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class PlateH
    : BSet {

    public int Sequence { get; set; }

    public int Status { get; set; }

    public int Entity { get; set; }

    public string Identifier { get; set; } = null!;

    public string State { get; set; } = null!;

    public string Country { get; set; } = null!;

    public DateOnly Expiration { get; set; }

    public int Truck { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Plate? PlateNavigation { get; set; }

    public virtual Truck? TruckNavigation { get; set; }


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Identifier), [new LengthValidator(8, 12)]),
            (nameof(State), [new LengthValidator(2, 3)]),
            (nameof(Country), [new LengthValidator(2, 3)]),
            (nameof(Expiration), [Required]),
            (nameof(Truck), [Required,new PointerValidator(true)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(Entity), [Required, new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<PlateH>(entity => {
            entity.ToTable("Plate_H");
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Id)
                .HasColumnName("id");

            entity.Property(e => e.Country)
                .HasMaxLength(3)
                .IsUnicode(false);
            entity.Property(e => e.Identifier)
                .HasMaxLength(12)
                .IsUnicode(false);
            entity.Property(e => e.State)
                .HasMaxLength(3)
                .IsUnicode(false);

            entity.HasOne(d => d.TruckNavigation)
                .WithMany(p => p.PlatesH)
                .HasForeignKey(d => d.Truck)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.PlatesH)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.PlateNavigation)
                .WithMany(p => p.PlatesH)
                .HasForeignKey(d => d.Entity)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
