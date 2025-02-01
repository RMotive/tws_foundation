using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;

public partial class Profile: BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public ICollection<AccountProfile> AccountProfiles { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Name), [new RequiredValidator(), new UniqueValidator(), new LengthValidator(Min: 1, Max: 25)]),
        ];
        return Container;
    }
    public static void CreateModel(ModelBuilder Builder) {

        Builder.Entity<Profile>(entity => {
            entity.HasKey(e => e.Id);

            entity.HasIndex(e => e.Name).IsUnique();

            entity.Property(e => e.Id);
            entity.Property(e => e.Description)
                .IsUnicode(false);
            entity.Property(e => e.Name)
                .HasMaxLength(25)
                .IsUnicode(false);
        });
    }
}


