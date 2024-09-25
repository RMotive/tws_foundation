using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class TrailerClass
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.Now;

    public string Name { get; set; } = null!;

    public int Axis { get; set; }

    public string? Description { get; set; }

    public virtual Axis? AxisNavigation { get; set; }

    public virtual ICollection<TrailerCommon> TrailersCommons { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Name), [Required, new LengthValidator(1, 30)]),
            (nameof(Axis), [new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<TrailerClass>(Entity => {
            Entity.ToTable("Trailer_Classes");
            Entity.HasKey(e => e.Id);


            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                 .HasColumnName("id");

            Entity.Property(e => e.Name)
                .HasMaxLength(30)
                .IsUnicode(false);

            Entity.Property(e => e.Description)
                .HasMaxLength(30)
                .IsUnicode(false);

            Entity.HasOne(d => d.AxisNavigation)
                .WithMany(p => p.TrailerClasses)
                .HasForeignKey(d => d.Axis)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
