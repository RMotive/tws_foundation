using CSM_Foundation.Core.Bases;
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class InsuranceH
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public int Sequence { get; set; }

    public int Status { get; set; }

    public int Entity {  get; set; }

    public string Policy { get; set; } = null!;

    public DateOnly Expiration { get; set; }

    public string Country { get; set; } = null!;

    public virtual Status? StatusNavigation { get; set; }

    public virtual Insurance? InsuranceNavigation { get; set; }

    public virtual ICollection<TruckH> TrucksH { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Policy), [new UniqueValidator(), new LengthValidator(1, 20),]),
            (nameof(Expiration), [Required, new UniqueValidator()]),
            (nameof(Country), [new LengthValidator(2, 3)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(Entity), [Required, new PointerValidator(true)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<InsuranceH>(entity => {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Id)
                .HasColumnName("id");

            entity.Property(e => e.Country)
                .HasMaxLength(3)
                .IsUnicode(false);

            entity.Property(e => e.Policy)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.InsurancesH)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.InsuranceNavigation)
                .WithMany(p => p.InsurancesH)
                .HasForeignKey(d => d.Entity)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
