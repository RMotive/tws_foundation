using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Approach
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.Now;

    public int Status { get; set; }

    public string? Enterprise { get; set; }

    public string? Personal { get; set; }

    public string? Alternative { get; set; }

    public string? Email { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<ApproachesH> ContactsH { get; set; } = [];

    public virtual ICollection<Carrier> Carriers { get; set; } = [];

    public virtual ICollection<Employee> Employees { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        Container = [
            ..Container,
            (nameof(Email), [new RequiredValidator(), new LengthValidator(Max: 30)]),
            (nameof(Status), [new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Approach>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Approaches");

            Entity.Property(e => e.Id)
                 .HasColumnName("id");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Enterprise)
                .HasMaxLength(13)
                .IsUnicode(false);

            Entity.Property(e => e.Personal)
                .HasMaxLength(13)
                .IsUnicode(false);

            Entity.Property(e => e.Alternative)
                .HasMaxLength(30)
                .IsUnicode(false);

            Entity.Property(e => e.Email)
                .HasMaxLength(30)
                .IsUnicode(false);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Contacts)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
