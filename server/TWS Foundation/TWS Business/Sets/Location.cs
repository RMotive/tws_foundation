using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Location
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public int Status { get; set; }

    public string Name { get; set; } = null!;

    public int Address { get; set; }

    public virtual Address? AddressNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<Section> Sections { get; set; } = [];

    public virtual ICollection<TrailerCommon> TrailersCommons { get; set; } = [];

    public virtual ICollection<TruckCommon> TrucksCommons { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Name), [Required, new LengthValidator(1, 30)]),
            (nameof(Status), [new PointerValidator(true)])
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Location>(Entity => {
            Entity.ToTable("Locations");
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Name)
                .HasMaxLength(30)
                .IsUnicode(false);

            Entity.HasOne(d => d.AddressNavigation)
                .WithMany(p => p.Locations)
                .HasForeignKey(d => d.Address);

            Entity.HasOne(d => d.StatusNavigation)
               .WithMany(p => p.Locations)
               .HasForeignKey(d => d.Status)
               .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
