using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class DriverExternal
    : BBusinessEntity {

    public int Status { get; set; }

    public Identification Identification { get; set; } = default!;

    public int Common { get; set; }

    public virtual Status? StatusNavigation { get; set; }

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

            Entity.HasIndex(e => e.Common)
               .IsUnique();

            Entity.HasOne(d => d.Identification)
                .WithMany(p => p.DriversExternals)
                .HasForeignKey(d => d.Identification);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.DriversExternals)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
