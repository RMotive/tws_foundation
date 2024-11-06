using System.Text.Json.Serialization;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;

public partial class Permit
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public int Solution { get; set; }
    [JsonIgnore]
    public virtual Solution? SolutionNavigation { get; set; }
    public int Feature { get; set; }
    [JsonIgnore]
    public virtual Feature? FeatureNavigation { get; set; }
    public int Action { get; set; }
    [JsonIgnore]
    public virtual Action? ActionNavigation { get; set; }

    public string Reference { get; set; } = default!;


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            ( nameof(Reference), [ new LengthValidator(8, 8) ] )
        ];
    }


    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Permit>(
            (Entity) => {
                Entity.HasKey(i => i.Id);

                Entity.HasIndex(i => new { i.Solution, i.Feature, i.Action })
                    .IsUnique();


                Entity.Property(i => i.Id)
                    .IsRequired();
                Entity.Property(i => i.Timestamp)
                    .IsRequired();
                Entity.Property(i => i.Solution)
                    .IsRequired();
                Entity.Property(i => i.Feature)
                    .IsRequired();
                Entity.Property(i => i.Action)
                    .IsRequired();
                Entity.Property(i => i.Reference)
                    .IsRequired()
                    .HasMaxLength(8);


                Entity.HasOne(i => i.SolutionNavigation)
                    .WithOne()
                    .HasForeignKey<Permit>(i => i.Solution);
                Entity.HasOne(i => i.FeatureNavigation)
                    .WithOne()
                    .HasForeignKey<Permit>(i => i.Feature);
                Entity.HasOne(i => i.ActionNavigation)
                    .WithOne()
                    .HasForeignKey<Permit>(i => i.Action);
            }
        );
    }
}
