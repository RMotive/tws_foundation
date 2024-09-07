﻿using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Driver
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public int Employee { get; set; }

    public int Common { get; set; }

    public string DriverType { get; set; } = null!;

    public DateOnly LicenseExpiration { get; set; }

    public DateOnly DrugalcRegistrationDate { get; set; }

    public DateOnly PullnoticeRegistrationDate { get; set; }

    public string? Twic { get; set; }

    public DateOnly? TwicExpiration { get; set; }

    public string? Visa { get; set; }

    public DateOnly? VisaExpiration { get; set; }

    public string? Fast { get; set; }

    public DateOnly? FastExpiration { get; set; }

    public string? Anam { get; set; }

    public DateOnly? AnamExpiration { get; set; }

    public virtual DriverCommon? DriverCommonNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Employee? EmployeeNavigation { get; set; }

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Status), [new PointerValidator(true)]),
            (nameof(Employee), [new PointerValidator(true)]),
            (nameof(DriverType), [Required, new LengthValidator(1,12)]),
            (nameof(Common), [new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<Driver>(entity => {
            entity.HasKey(e => e.Id);
            entity.ToTable("Drivers");

            entity.Property(e => e.Id)
                 .HasColumnName("id");

            entity.Property(e => e.DriverType)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.Property(e => e.Twic)
               .HasColumnName("TWIC");
            entity.Property(e => e.Twic)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.Property(e => e.Visa)
               .HasColumnName("VISA");
            entity.Property(e => e.Visa)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.Property(e => e.Fast)
               .HasColumnName("FAST");
            entity.Property(e => e.Fast)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.Property(e => e.Anam)
               .HasColumnName("ANAM");
            entity.Property(e => e.Anam)
                .HasMaxLength(24)
                .IsUnicode(false);

            entity.HasOne(d => d.DriverCommonNavigation)
                .WithMany(p => p.Drivers)
                .HasForeignKey(d => d.Common);

            entity.HasOne(d => d.EmployeeNavigation)
                .WithMany(p => p.Drivers)
                .HasForeignKey(d => d.Employee);

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Drivers)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
