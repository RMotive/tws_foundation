using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Usdot
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public string Mc { get; set; } = null!;

    public string Scac { get; set; } = null!;

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<UsdotH> UsdotsH { get; set; } = [];

    public virtual ICollection<Carrier> Carriers { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Mc), [Required, new LengthValidator(7, 7)]),
            (nameof(Scac), [Required, new LengthValidator(4, 4)]),
            (nameof(Status), [new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder builder) {
        builder.Entity<Usdot>(entity => {
            entity.ToTable("USDOT");
            entity.HasKey(e => e.Id);

            entity.HasKey(e => e.Id);
            entity.Property(e => e.Id)
               .HasColumnName("id");

            entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            entity.Property(e => e.Mc)
                .HasMaxLength(7)
                .IsUnicode(false)
                .HasColumnName("MC");

            entity.Property(e => e.Scac)
                .HasMaxLength(4)
                .IsUnicode(false)
                .HasColumnName("SCAC");

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Usdots)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
