﻿using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Situation
    : BDatabaseSet {
    public override int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public virtual ICollection<DriverCommon>? DriversCommons { get; set; } = [];

    public virtual ICollection<TruckCommon>? TrucksCommons { get; set; } = [];

    public virtual ICollection<TrailerCommon>? TrailersCommons { get; set; } = [];

    public virtual ICollection<TruckH> TrucksH { get; set; } = [];

    public static void Set(ModelBuilder builder) {
        _ = builder.Entity<Situation>(entity => {
            _ = entity.HasKey(e => e.Id);

            _ = entity.HasIndex(e => e.Name)
                .IsUnique();

            _ = entity.Property(e => e.Id)
                .HasColumnName("id");
            _ = entity.Property(e => e.Description)
                .HasMaxLength(100);
            _ = entity.Property(e => e.Name)
                .HasMaxLength(25);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        Container = [
            ..Container,
            (nameof(Name), [Required, new LengthValidator(1, 25)]),
        ];
        return Container;
    }
}
