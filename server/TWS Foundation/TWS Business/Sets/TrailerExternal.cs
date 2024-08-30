﻿using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class TrailerExternal
    : BDatabaseSet {
    public override int Id { get; set; }

    public int Status { get; set; }

    public int Common { get; set; }

    public string? UsaPlate { get; set; } = null!;

    public string MxPlate { get; set; } = null!;

    public virtual Status? StatusNavigation { get; set; }

    public virtual TrailerCommon? TrailerCommonNavigation { get; set; }

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Common), [Required, new PointerValidator(true)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(MxPlate), [new LengthValidator(8, 12)]),

        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        _ = builder.Entity<TrailerExternal>(entity => {
            _ = entity.HasKey(e => e.Id);
            _ = entity.ToTable("Trailers_Externals");

            _ = entity.Property(e => e.Id)
                 .HasColumnName("id");

            _ = entity.Property(e => e.UsaPlate)
              .HasMaxLength(12)
              .IsUnicode(false);

            _ = entity.Property(e => e.MxPlate)
              .HasMaxLength(12)
              .IsUnicode(false);

            _ = entity.HasOne(d => d.TrailerCommonNavigation)
               .WithMany(p => p.TrailersExternals)
               .HasForeignKey(d => d.Common);

            _ = entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.TrailersExternals)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);

        });
    }
}
