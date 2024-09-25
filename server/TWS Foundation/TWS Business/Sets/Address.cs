using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Address
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.Now;

    public string? State { get; set; }

    public string? Street { get; set; }

    public string? AltStreet { get; set; }

    public string? City { get; set; }

    public string? Zip { get; set; }

    public string Country { get; set; } = null!;

    public string? Colonia { get; set; }

    public virtual ICollection<Employee> Employees { get; set; } = [];

    public virtual ICollection<Location> Locations { get; set; } = [];

    public virtual ICollection<Carrier> Carriers { get; set; } = [];

    public virtual ICollection<CarrierH> CarriersH { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
                .. Container,
            (nameof(Country), [new RequiredValidator(), new LengthValidator(3)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Address>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Addresses");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Street)
                .HasMaxLength(100)
                .IsUnicode(false);

            Entity.Property(e => e.AltStreet)
                .HasMaxLength(100)
                .IsUnicode(false);

            Entity.Property(e => e.City)
                .HasMaxLength(30)
                .IsUnicode(false);

            Entity.Property(e => e.Zip)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("ZIP");

            Entity.Property(e => e.Country)
                .HasMaxLength(3)
                .IsUnicode(false);

            Entity.Property(e => e.Colonia)
                .HasMaxLength(30)
                .IsUnicode(false);
        });
    }
}
