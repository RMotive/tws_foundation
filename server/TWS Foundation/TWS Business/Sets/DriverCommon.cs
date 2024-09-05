using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class DriverCommon
    : BDatabaseSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public string License { get; set; } = null!;

    public int? Situation { get; set; }

    public virtual Situation? SituationNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<Driver> Drivers { get; set; } = [];

    public virtual ICollection<DriverExternal> DriversExternals { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(License), [Required, new LengthValidator(8,12)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<DriverCommon>(entity => {
            entity.HasKey(e => e.Id);
            entity.ToTable("Drivers_Commons");

            entity.Property(e => e.Id)
                 .HasColumnName("id");

            entity.Property(e => e.License)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.DriversCommons)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.SituationNavigation)
                .WithMany(p => p.DriversCommons)
                .HasForeignKey(d => d.Situation)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
