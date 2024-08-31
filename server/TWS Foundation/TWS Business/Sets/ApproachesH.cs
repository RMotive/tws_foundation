﻿using CSM_Foundation.Core.Bases;
using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class ApproachesH
    : BDatabaseSet {
    public override int Id { get; set; }

    //public override DateTime Timemark { get; set; }

    public int Sequence { get; set; }

    public int Status { get; set; }

    public int Entity { get; set; }

    public string? Enterprise { get; set; }

    public string? Personal { get; set; }

    public string? Alternative { get; set; }

    public string? Email { get; set; }

    public virtual Approach? ApproachNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<CarrierH> CarriersH { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Email), [Required, new LengthValidator(1, 30)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(Entity), [Required, new PointerValidator(true)])
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        _ = builder.Entity<ApproachesH>(entity => {
            _ = entity.HasKey(e => e.Id);
            _ = entity.Property(e => e.Id)
               .HasColumnName("id");
            _ = entity.ToTable("Approaches_H");

            _ = entity.Property(e => e.Enterprise)
                .HasMaxLength(13)
                .IsUnicode(false);

            _ = entity.Property(e => e.Personal)
                .HasMaxLength(13)
                .IsUnicode(false);

            _ = entity.Property(e => e.Alternative)
                .HasMaxLength(30)
                .IsUnicode(false);

            _ = entity.Property(e => e.Email)
                .HasMaxLength(30)
                .IsUnicode(false);

            _ = entity.HasOne(d => d.ApproachNavigation)
                .WithMany(p => p.ContactsH)
                .HasForeignKey(d => d.Entity)
                .OnDelete(DeleteBehavior.ClientSetNull);

            _ = entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.ContactsH)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
