

using System.Diagnostics.Metrics;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;
public class Waypoint 
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public int Status { get; set; }

    public decimal Longitude { get; set; }

    public decimal Latitude { get; set; }

    public decimal? Altitude { get; set; }

    public virtual ICollection<Location> Locations { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
                .. Container,
            (nameof(Longitude), [new RequiredValidator()]),
            (nameof(Latitude), [new RequiredValidator()]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Waypoint>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Waypoints");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Longitude)
            .HasColumnType("decimal(10, 6)")
            .IsRequired();

            Entity.Property(e => e.Latitude)
            .HasColumnType("decimal(10, 6)")
            .IsRequired();

            Entity.Property(e => e.Altitude)
            .HasColumnType("decimal(10, 6)");

        });
    }
}

