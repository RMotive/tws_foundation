using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;
public class Action
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public string Name { get; set; } = default!;
    public string? Description { get; set; }
    public bool Enabled { get; set; }

    public virtual ICollection<Permit> Permits { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ( nameof(Name), [ new LengthValidator(1, 25) ] )
        ];
    }

    static public void CreateModel(ModelBuilder Builder) {
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
