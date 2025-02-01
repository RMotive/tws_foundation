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

    public int Feature { get; set; }

    public int Action { get; set; }

    public string Reference { get; set; } = default!;

    public bool Enabled { get; set; }

    public virtual Solution? SolutionNavigation { get; set; }

    public virtual Feature? FeatureNavigation { get; set; }

    public virtual Action? ActionNavigation { get; set; }

    public ICollection<AccountPermit> AccountPermits { get; set; } = [];

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
                Entity.Property(i => i.Enabled)
                    .IsRequired();


                Entity.HasOne(i => i.SolutionNavigation)
                    .WithMany(i => i.Permits)
                    .HasForeignKey(i => i.Solution)
                    .HasConstraintName("FK_Permits_Solutions");
                Entity.HasOne(i => i.FeatureNavigation)
                    .WithMany(i => i.Permits)
                    .HasForeignKey(i => i.Feature)
                    .HasConstraintName("FK_Permits_Features");
                Entity.HasOne(i => i.ActionNavigation)
                    .WithMany(i => i.Permits)
                    .HasForeignKey(i => i.Action)
                    .HasConstraintName("FK_Permits_Actions");
            }
        );
    }

    /// <summary>
    ///     Stores a static catalog of <see cref="Permit"/> references.
    /// </summary>
    public enum References {
        /// <summary>
        ///     <para> Solution: TWSMF </para>
        ///     <para> Feature: Development </para>
        ///     <para> Action: Qualify </para>
        /// </summary>
        TWSMFD01,
    }
}