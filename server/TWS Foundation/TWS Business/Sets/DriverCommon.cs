using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class DriverCommon
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.Now;

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
            (nameof(Status), [new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<DriverCommon>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Drivers_Commons");

            Entity.Property(e => e.Id)
                 .HasColumnName("id");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.License)
                .HasMaxLength(12)
                .IsUnicode(false);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.DriversCommons)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.SituationNavigation)
                .WithMany(p => p.DriversCommons)
                .HasForeignKey(d => d.Situation)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
