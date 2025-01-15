﻿
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class YardLog
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public bool Entry { get; set; }

    public int? Truck { get; set; }

    public int? TruckExternal { get; set; }

    public int? Trailer { get; set; }

    public int? TrailerExternal { get; set; }

    public int LoadType { get; set; }

    public int? Section { get; set; }

    public int? Driver { get; set; }

    public int? DriverExternal { get; set; }

    public int Guard { get; set; }

    public string Gname { get; set; } = null!;

    public string? Seal { get; set; }

    public string? SealAlt { get; set; }

    public string FromTo { get; set; } = null!;

    public bool Damage { get; set; }

    public string TTPicture { get; set; } = null!;

    public string? DmgEvidence { get; set; }

    public virtual Driver? DriverNavigation { get; set; }

    public virtual DriverExternal? DriverExternalNavigation { get; set; }

    public virtual Truck? TruckNavigation { get; set; }

    public virtual TruckExternal? TruckExternalNavigation { get; set; }

    public virtual Trailer? TrailerNavigation { get; set; }

    public virtual TrailerExternal? TrailerExternalNavigation { get; set; }

    public virtual LoadType? LoadTypeNavigation { get; set; }

    public virtual Section? SectionNavigation { get; set; }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator required = new();
        Container = [
            ..Container,
            (nameof(TTPicture), [required]),
            (nameof(Gname), [new LengthValidator(1, 100)]),
            (nameof(FromTo), [new LengthValidator(1, 100)]),
            (nameof(LoadType), [new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<YardLog>(entity => {
            entity.HasKey(e => e.Id);
            entity.ToTable("Yard_Logs", tb => tb.HasTrigger("YardLogs_InsertInto_TrucksInventories"));

            entity.Property(e => e.Id)
                 .HasColumnName("id");

            entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            entity.Property(e => e.Gname)
                .HasMaxLength(100)
                .IsUnicode(false);

            entity.Property(e => e.Seal)
                .HasMaxLength(64)
                .IsUnicode(false);

            entity.Property(e => e.SealAlt)
                .HasMaxLength(64)
                .IsUnicode(false);

            entity.Property(e => e.FromTo)
                .HasMaxLength(100)
                .IsUnicode(false);

            entity.Property(e => e.TTPicture)
                .IsUnicode(false);

            entity.Property(e => e.DmgEvidence)
               .IsUnicode(false);

            entity.HasOne(d => d.DriverNavigation)
                .WithMany(p => p.YardLogs)
                .HasForeignKey(d => d.Driver)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.DriverExternalNavigation)
               .WithMany(p => p.YardLogs)
               .HasForeignKey(d => d.DriverExternal)
               .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.TruckNavigation)
               .WithMany(p => p.YardLogs)
               .HasForeignKey(d => d.Truck)
               .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.TruckExternalNavigation)
               .WithMany(p => p.YardLogs)
               .HasForeignKey(d => d.TruckExternal)
               .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.TrailerNavigation)
               .WithMany(p => p.YardLogs)
               .HasForeignKey(d => d.Trailer)
               .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.TrailerExternalNavigation)
               .WithMany(p => p.YardLogs)
               .HasForeignKey(d => d.TrailerExternal)
               .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.LoadTypeNavigation)
               .WithMany(p => p.YardLogs)
               .HasForeignKey(d => d.LoadType)
               .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.SectionNavigation)
               .WithMany(p => p.YardLogs)
               .HasForeignKey(d => d.Section)
               .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
