using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class TruckInventory
    : BSet {

    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public DateTime EntryDate { get; set; }

    public int Section { get; set; }

    public int? Truck { get; set; }

    public int? TruckExternal {  get; set; }

    public virtual Truck? TruckNavigation { get; set; }

    public virtual TruckExternal? TruckExternalNavigation { get; set; }

    public virtual Section? SectionNavigation { get; set; }


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
                .. Container,
            (nameof(Section), [new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<TruckInventory>(Entity => {
            Entity.ToTable("Trucks_Inventories", tb => tb.HasTrigger("TruckInventories_Management"));
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");
            Entity.Property(e => e.EntryDate)
               .HasColumnType("datetime");

            Entity.Property(e => e.Section)
                 .HasColumnName("section");
            Entity.Property(e => e.Truck)
                .HasColumnName("truck");
            Entity.Property(e => e.TruckExternal)
                .HasColumnName("truckExternal");

            Entity.HasOne(d => d.TruckNavigation)
                .WithMany(p => p.TrucksInventories)
                .HasForeignKey(d => d.Truck)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.TruckExternalNavigation)
                .WithMany(p => p.TrucksInventories)
                .HasForeignKey(d => d.TruckExternal)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.SectionNavigation)
               .WithMany(p => p.TrucksInventories)
               .HasForeignKey(d => d.Section)
               .OnDelete(DeleteBehavior.ClientSetNull);

        });
    }
}
