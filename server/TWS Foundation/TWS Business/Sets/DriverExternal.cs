using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class DriverExternal
    : BDatabaseSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

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
            (nameof(Common), [new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<DriverExternal>(entity => {
            entity.HasKey(e => e.Id);
            entity.ToTable("Drivers_Externals");

            entity.Property(e => e.Id)
                 .HasColumnName("id");

            entity.HasOne(d => d.DriverCommonNavigation)
               .WithMany(p => p.DriversExternals)
               .HasForeignKey(d => d.Common);

            entity.HasOne(d => d.IdentificationNavigation)
                .WithMany(p => p.DriversExternals)
                .HasForeignKey(d => d.Identification);

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.DriversExternals)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
