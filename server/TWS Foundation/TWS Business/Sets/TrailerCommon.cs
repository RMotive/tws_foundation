using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class TrailerCommon
    : BSet {
    

    

    public int Status { get; set; }

    public string Economic { get; set; } = null!;

    public int? Type { get; set; }

    public int? Situation { get; set; }

    public int? Location { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual TrailerType? TrailerTypeNavigation { get; set; }

    public virtual Situation? SituationNavigation { get; set; }

    public virtual Location? LocationNavigation { get; set; }

    public virtual ICollection<Trailer> Trailers { get; set; } = [];

    public virtual ICollection<TrailerExternal> TrailersExternals { get; set; } = [];



    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Economic), [Required, new LengthValidator(1, 16)]),
            (nameof(Status), [new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<TrailerCommon>(Entity => {
            Entity.ToTable("Trailers_Commons");
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Economic)
                .HasMaxLength(16)
                .IsUnicode(false);

            Entity.HasOne(d => d.TrailerTypeNavigation)
                .WithMany(p => p.TrailersCommons)
                .HasForeignKey(d => d.Type);

            Entity.HasOne(d => d.SituationNavigation)
                .WithMany(p => p.TrailersCommons)
                .HasForeignKey(d => d.Situation);

            Entity.HasOne(d => d.LocationNavigation)
                .WithMany(p => p.TrailersCommons)
                .HasForeignKey(d => d.Location)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.TrailersCommons)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
