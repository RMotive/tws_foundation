using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class TruckInventory
    : BBusinessEntity {

    

    

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

        });
    }
}
