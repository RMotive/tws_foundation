using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;

public partial class Solution 
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public string Name { get; set; } = null!;

    public string Sign { get; set; } = null!;

    public string? Description { get; set; }

    public virtual ICollection<Permit> Permits { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Name), [new UniqueValidator(), new LengthValidator(1, 40)]),
            (nameof(Sign), [new UniqueValidator(), new LengthValidator(5, 5)]),
        ];
        return Container;
    }


    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Solution>(entity => {
            entity.HasKey(e => e.Id);

            entity.HasIndex(e => e.Sign)
            .IsUnique();

            entity.HasIndex(e => e.Name)
            .IsUnique();

            entity.Property(e => e.Description)
            .IsUnicode(false);
            
            entity.Property(e => e.Name)
            .HasMaxLength(25)
            .IsUnicode(false);
            
            entity.Property(e => e.Sign)
            .HasMaxLength(5)
            .IsUnicode(false);

            entity.Property(e => e.Timestamp)
            .HasColumnType("datetime");
        });
    }
}
