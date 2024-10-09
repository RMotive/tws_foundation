using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class TrailerType
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public int Status { get; set; }

    public string Size { get; set; } = null!;

    public int TrailerClass { get; set; }

    public virtual TrailerClass? TrailerClassNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<TrailerCommon> TrailersCommons { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
                .. Container,
            (nameof(Status), [new PointerValidator(true)]),
            (nameof(Size), [new RequiredValidator(), new LengthValidator(Max: 16)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<TrailerType>(Entity => {
            Entity.ToTable("Trailers_Types");
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                 .HasColumnName("id");

            Entity.Property(e => e.Size)
                .HasMaxLength(16)
                .IsUnicode(false);

            Entity.HasOne(d => d.TrailerClassNavigation)
                .WithMany(p => p.TrailersTypesCommons)
                .HasForeignKey(d => d.TrailerClass)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.TrailerTypes)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);

        });
    }
}
