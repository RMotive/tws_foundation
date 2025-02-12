using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class TruckExternal
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public int Status { get; set; }

    public int Common { get; set; }

    public string Carrier { get; set; } = null!;

    public string? Vin { get; set; }

    public string? UsaPlate { get; set; }

    public string? MxPlate { get; set; } = null!;

    public virtual Status? StatusNavigation { get; set; }

    public virtual TruckCommon? TruckCommonNavigation { get; set; }

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];

    public virtual ICollection<TruckInventory> TrucksInventories { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Common), [new UniqueValidator()]),
            (nameof(Status), [Required, new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<TruckExternal>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Trucks_Externals");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                 .HasColumnName("id");

            Entity.Property(e => e.Vin)
                 .HasColumnName("VIN")
                 .HasMaxLength(17);

            Entity.Property(e => e.UsaPlate)
              .HasMaxLength(12)
              .IsUnicode(false);

            Entity.Property(e => e.Carrier)
              .HasMaxLength(100)
              .IsUnicode(false);

            Entity.Property(e => e.MxPlate)
              .HasMaxLength(12)
              .IsUnicode(false);

            Entity.HasOne(d => d.TruckCommonNavigation)
               .WithMany(p => p.TrucksExternals)
               .HasForeignKey(d => d.Common);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.TrucksExternals)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
