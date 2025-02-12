using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class UsdotH
    : BSet {

    

    

    public int Sequence { get; set; }

    public int Status { get; set; }

    public int Entity { get; set; }
    public string Mc { get; set; } = null!;

    public string Scac { get; set; } = null!;
    public virtual Usdot? UsdotNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<CarrierH> CarriersH { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Mc), [Required, new LengthValidator(7, 7)]),
            (nameof(Scac), [Required, new LengthValidator(4, 4)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(Entity), [Required, new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<UsdotH>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.Property(e => e.Id)
               .HasColumnName("id");
            Entity.ToTable("USDOT_H");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Mc)
                .HasMaxLength(7)
                .IsUnicode(false)
                .HasColumnName("MC");

            Entity.Property(e => e.Scac)
                .HasMaxLength(4)
                .IsUnicode(false)
                .HasColumnName("SCAC");

            Entity.HasOne(d => d.UsdotNavigation)
                .WithMany(p => p.UsdotsH)
                .HasForeignKey(d => d.Entity)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.UsdotsH)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
