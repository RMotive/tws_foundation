﻿using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class DriverExternal
    : BDatabaseSet {
    public override int Id { get; set; }

    public int Status { get; set; }

    public int Identification { get; set; }

    public int Common { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Identification? IdentificationNavigation { get; set; }

    public virtual DriverCommon? DriverCommonNavigation { get; set; }


    public virtual ICollection<YardLog> YardLogs { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
                .. Container,
            (nameof(Status), [new PointerValidator(true)]),
            (nameof(Identification), [new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        _ = builder.Entity<DriverExternal>(entity => {
            _ = entity.HasKey(e => e.Id);
            _ = entity.ToTable("Drivers_Externals");

            _ = entity.Property(e => e.Id)
                 .HasColumnName("id");

            _ = entity.HasOne(d => d.DriverCommonNavigation)
               .WithMany(p => p.DriversExternals)
               .HasForeignKey(d => d.Common);

            _ = entity.HasIndex(e => e.Common)
               .IsUnique();

            _ = entity.HasOne(d => d.IdentificationNavigation)
                .WithMany(p => p.DriversExternals)
                .HasForeignKey(d => d.Identification);

            _ = entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.DriversExternals)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
