using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets.Solutions;

public partial class Solution
    : BSet {
    /// <summary>
    ///     Solution unique sign to reference easyly the solution along operations.
    /// </summary>
    /// <remarks>
    ///     Must be unique along records. 5 Restricted Length.
    /// </remarks>
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

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<Solution>(
            (Entity) => {
                Entity
                    .HasKey(e => e.Id);

                Entity
                    .HasIndex(e => e.Sign)
                    .IsUnique();
                Entity.Property(e => e.Sign)
                    .IsFixedLength(true)
                    .HasMaxLength(5)
                    .IsRequired();

                Entity
                    .HasIndex(e => e.Name)
                    .IsUnique();
                Entity
                    .Property(e => e.Name)
                    .IsFixedLength(true)
                    .HasMaxLength(25)
                    .IsRequired();

                Entity
                    .Property(e => e.Description);

                Entity
                    .Property(e => e.Timestamp)
                    .IsRequired()
                    .HasColumnType("datetime");
            }
        );
    }
}
