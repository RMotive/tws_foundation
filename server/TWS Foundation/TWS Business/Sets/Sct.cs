﻿using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Sct
    : BDatabaseSet {
    public override int Id { get; set; }

    public int Status { get; set; }

    public string Type { get; set; } = null!;

    public string Number { get; set; } = null!;

    public string Configuration { get; set; } = null!;
    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<Carrier> Carriers { get; set; } = [];

    public virtual ICollection<SctH> SctsH { get; set; } = [];


    public static void Set(ModelBuilder builder) {
        _ = builder.Entity<Sct>(entity => {
            _ = entity.HasKey(e => e.Id);
            _ = entity.Property(e => e.Id)
               .HasColumnName("id");
            _ = entity.ToTable("SCT");

           
            _ = entity.Property(e => e.Configuration)
                .HasMaxLength(10)
                .IsUnicode(false);
            _ = entity.Property(e => e.Number)
                .HasMaxLength(25)
                .IsUnicode(false);
            _ = entity.Property(e => e.Type)
                .HasMaxLength(6)
                .IsUnicode(false);

            _ = entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Scts)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        Container = [
            ..Container,
            (nameof(Type), [Required, new LengthValidator(6,6)]),
            (nameof(Number), [Required, new LengthValidator(25,25)]),
            (nameof(Configuration), [Required, new LengthValidator(6,10)]),
            (nameof(Status), [Required, new PointerValidator(true)]),

        ];
        return Container;
    }
}