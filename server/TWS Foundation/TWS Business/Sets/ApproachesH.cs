using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class ApproachesH
    : BSet {

    public int Sequence { get; set; }

    public int Status { get; set; }

    public int Entity { get; set; }

    public string? Enterprise { get; set; }

    public string? Personal { get; set; }

    public string? Alternative { get; set; }

    public string? Email { get; set; }

    public virtual Approach? ApproachNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<CarrierH> CarriersH { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Email), [Required, new LengthValidator(1, 30)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(Entity), [Required, new PointerValidator(true)])
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<ApproachesH>(Entity => {
            Entity.ToTable("Approaches_H");
            Entity.HasKey(e => e.Id);

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

            Entity.HasOne(d => d.ApproachNavigation)
                .WithMany(p => p.ContactsH)
                .HasForeignKey(d => d.Entity)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.ContactsH)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
