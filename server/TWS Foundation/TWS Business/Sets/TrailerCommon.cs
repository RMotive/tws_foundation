using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class TrailerCommon
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public string Economic { get; set; } = null!;

    public int? Class { get; set; }


    public int? Situation { get; set; }

    public int? Location { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual TrailerClass? TrailerClassNavigation { get; set; }

    public virtual Situation? SituationNavigation { get; set; }

    public virtual Location? LocationNavigation { get; set; }

    public virtual ICollection<Trailer> Trailers { get; set; } = [];

    public virtual ICollection<TrailerExternal> TrailersExternals { get; set; } = [];



    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Economic), [Required, new LengthValidator(1, 16)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<TrailerCommon>(entity => {
            entity.ToTable("Trailers_Commons");
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Id)
                .HasColumnName("id");

            entity.Property(e => e.Economic)
                .HasMaxLength(16)
                .IsUnicode(false);

            entity.HasOne(d => d.TrailerClassNavigation)
                .WithMany(p => p.TrailersCommons)
                .HasForeignKey(d => d.Class);
            
            entity.HasOne(d => d.SituationNavigation)
                .WithMany(p => p.TrailersCommons)
                .HasForeignKey(d => d.Situation);

            entity.HasOne(d => d.LocationNavigation)
                .WithMany(p => p.TrailersCommons)
                .HasForeignKey(d => d.Location)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.TrailersCommons)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
