using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;

public partial class Feature
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;


    public string Name { get; set; } = default!;
    public string? Description { get; set; }
    public bool Enabled { get; set; }

    public virtual ICollection<Permit> Permits { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        return [
            ..Container,
            ( nameof(Name), [ new LengthValidator(1, 25) ] )
        ];
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Feature>(
            (Entity) => {
                Entity.HasKey(x => x.Id);

                Entity.HasIndex(i => i.Name)
                    .IsUnique();

                Entity.Property(i => i.Id)
                    .IsRequired();
                Entity.Property(i => i.Name)
                    .IsRequired()
                    .HasMaxLength(25);
                Entity.Property(i => i.Description);
                Entity.Property(i => i.Timestamp);
                Entity.Property(i => i.Enabled);
            }
        );
    }
}
