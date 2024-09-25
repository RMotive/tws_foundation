using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Section
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.Now;

    public int Status { get; set; }

    public string Name { get; set; } = null!;

    public int Yard { get; set; }

    public int Capacity { get; set; }

    public int Ocupancy { get; set; }


    public virtual Status? StatusNavigation { get; set; }

    public virtual Location? LocationNavigation { get; set; }

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
                .. Container,
            (nameof(Status), [new PointerValidator(true)]),
            (nameof(Yard), [new PointerValidator(true)]),
            (nameof(Name), [new LengthValidator(1,32)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Section>(Entity => {
            Entity.ToTable("Sections");
            Entity.HasKey(e => e.Id);


            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Name)
                .HasMaxLength(32)
                .IsUnicode(false);

            Entity.HasOne(d => d.LocationNavigation)
                .WithMany(p => p.Sections)
                .HasForeignKey(d => d.Yard);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Sections)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
