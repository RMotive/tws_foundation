using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class DriverExternal
    : BSet {

    public int Status { get; set; }

    public int Identification { get; set; }

    public int Common { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Identification? IdentificationNavigation { get; set; }

    public virtual DriverCommon? DriverCommonNavigation { get; set; }


    public virtual ICollection<YardLog> YardLogs { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
            ..Container,
            (nameof(Status), [new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<DriverExternal>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Drivers_Externals");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.HasOne(d => d.DriverCommonNavigation)
                .WithMany(p => p.DriversExternals)
                .HasForeignKey(d => d.Common);

            Entity.HasIndex(e => e.Common)
               .IsUnique();

            Entity.HasOne(d => d.IdentificationNavigation)
                .WithMany(p => p.DriversExternals)
                .HasForeignKey(d => d.Identification);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.DriversExternals)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
