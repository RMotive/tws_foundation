﻿using System.Diagnostics.Metrics;

using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Usdot
    : BDatabaseSet {
    public override int Id { get; set; }

    public int Status { get; set; }

    public string Mc {  get; set; } = null!;

    public string Scac { get; set; } = null!;

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<UsdotH> UsdotsH { get; set; } = [];

    public virtual ICollection<Carrier> Carriers { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Mc), [Required, new LengthValidator(7, 7)]),
            (nameof(Scac), [Required, new LengthValidator(4, 4)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        _ = builder.Entity<Usdot>(entity => {
            _ = entity.HasKey(e => e.Id);
            _ = entity.ToTable("USDOT");

            _ = entity.HasKey(e => e.Id);
            _ = entity.Property(e => e.Id)
               .HasColumnName("id");

            _ = entity.Property(e => e.Mc)
                .HasMaxLength(7)
                .IsUnicode(false)
                .HasColumnName("MC");

            _ = entity.Property(e => e.Scac)
                .HasMaxLength(4)
                .IsUnicode(false)
                .HasColumnName("SCAC");

            _ = entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Usdots)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
