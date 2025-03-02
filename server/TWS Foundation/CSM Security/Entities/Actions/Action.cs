using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using CSM_Security.Entities.Permits;

using Microsoft.EntityFrameworkCore;

namespace CSM_Security.Entities.Actions;
public class Action
    : BSecurityDatabaseEntity, IEntity_Name {

    [StringLength(100)]
    public string Name { get; set; } = default!;

    public string? Description { get; set; }
    public bool Enabled { get; set; }

    public virtual ICollection<Permit> Permits { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ( nameof(Name), [ new LengthValidator(1, 25) ] )
        ];
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Action>(
            (Entity) => {
                Entity.HasKey(i => i.Id);

                Entity.HasIndex(i => i.Name)
                    .IsUnique();

                Entity.Property(i => i.Id);
                Entity.Property(i => i.Name)
                    .IsRequired()
                    .HasMaxLength(25);
                Entity.Property(i => i.Description);
                Entity.Property(i => i.Timestamp);
                Entity.Property(i => i.Enabled);
            }
        );
    }

    protected override void DescribeSet(ModelBuilder Builder) { }
}
