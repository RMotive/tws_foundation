﻿using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Plate
    : BDatabaseSet {
    public override int Id { get; set; }

    public string Identifier { get; set; } = null!;

    public string State { get; set; } = null!;

    public string Country { get; set; } = null!;

    public DateOnly Expiration { get; set; }

    public int Truck { get; set; }

    public virtual Truck? TruckNavigation { get; set; }

    public static void Set(ModelBuilder builder) {
        builder.Entity<Plate>(entity => {
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Id);
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
                .WithMany(p => p.Plates)
                .HasForeignKey(d => d.Truck)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        Container = [
            ..Container,
            (nameof(Identifier), [new LengthValidator(8, 12)]),
            (nameof(State), [new LengthValidator(2, 3)]),
            (nameof(Country), [new LengthValidator(2, 3)]),
            (nameof(Expiration), [Required]),
            (nameof(Truck), [Required,new PointerValidator(true)]),

        ];
        return Container;
    }
}
