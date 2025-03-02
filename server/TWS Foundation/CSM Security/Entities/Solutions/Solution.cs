using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using CSM_Security.Entities.Permits;

using Microsoft.EntityFrameworkCore;

namespace CSM_Security.Entities.Solutions;

public partial class Solution
    : BSecurityDatabaseEntity, IEntity_Name {

    public string Name { get; set; } = default!;

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
                Entity.Property(e => e.Sign).IsFixedLength(true).HasMaxLength(5).IsRequired();
                Entity.HasIndex(e => e.Sign).IsUnique();
            }
        );
    }
}
