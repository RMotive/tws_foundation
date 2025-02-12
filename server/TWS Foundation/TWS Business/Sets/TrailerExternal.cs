using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class TrailerExternal
    : BSet {
    

    

    public int Status { get; set; }

    public int Common { get; set; }

    public string Carrier { get; set; } = null!;

    public string? MxPlate { get; set; }

    public string? UsaPlate { get; set; } = null!;

    public virtual Status? StatusNavigation { get; set; }

    public virtual TrailerCommon? TrailerCommonNavigation { get; set; }

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Common), [new UniqueValidator()]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(Carrier), [new LengthValidator(1, 100)]),

        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<TrailerExternal>(Entity => {
            Entity.ToTable("Trailers_Externals");
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.UsaPlate)
                .HasMaxLength(12)
                .IsUnicode(false);

            Entity.Property(e => e.Carrier)
                .HasMaxLength(100)
                .IsUnicode(false);

            Entity.Property(e => e.MxPlate)
                .HasMaxLength(12)
                .IsUnicode(false);

            Entity.HasOne(d => d.TrailerCommonNavigation)
                .WithMany(p => p.TrailersExternals)
                .HasForeignKey(d => d.Common);
            Entity.HasIndex(e => e.Common)
                .IsUnique();

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.TrailersExternals)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
