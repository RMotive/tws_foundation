using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class TrailerExternal
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public int Common { get; set; }

    public string Carrier { get; set; } = null!;

    public string MxPlate { get; set; } = null!;

    public string? UsaPlate { get; set; } = null!;

    public virtual Status? StatusNavigation { get; set; }

    public virtual TrailerCommon? TrailerCommonNavigation { get; set; }

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Common), [Required, new PointerValidator(true)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(MxPlate), [new LengthValidator(8, 12)]),
            (nameof(Carrier), [new LengthValidator(1, 100)]),

        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<TrailerExternal>(entity => {
            entity.ToTable("Trailers_Externals");
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Id)
                .HasColumnName("id");

            entity.Property(e => e.UsaPlate)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.Property(e => e.Carrier)
                .HasMaxLength(100)
                .IsUnicode(false);

            entity.Property(e => e.MxPlate)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.HasOne(d => d.TrailerCommonNavigation)
                .WithMany(p => p.TrailersExternals)
                .HasForeignKey(d => d.Common);

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.TrailersExternals)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
