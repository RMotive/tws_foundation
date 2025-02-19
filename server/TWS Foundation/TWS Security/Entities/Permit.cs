using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

using TWS_Security.Entities.Accounts;
using TWS_Security.Entities.Solutions;

namespace TWS_Security.Entities;

public class Permit
    : BSecurityDatabaseEntity {


    /// <summary>
    ///     Solution information.
    /// </summary>
    public Solution Solution { get; set; } = default!;

    /// <summary>
    ///     Feature information.
    /// </summary>
    public Feature Feature { get; set; } = default!;

    /// <summary>
    ///     Action information.
    /// </summary>
    public Action Action { get; set; } = default!;

    /// <summary>
    ///     Unique identifier reference.
    /// </summary>
    public string Reference { get; set; } = string.Empty;

    /// <summary>
    ///     Wheter the Permit is globally enabled.
    /// </summary>
    public bool Enabled { get; set; }

    /// <summary>
    ///     <see cref="Profile"/>s that references this <see cref="Permit"/>.
    /// </summary>
    public ICollection<Profile> Profiles { get; set; } = [];

    /// <summary>
    ///     <see cref="Account"/>s that references this <see cref="Permit"/>.
    /// </summary>
    public ICollection<Account> Accounts { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            ( nameof(Reference), [ new LengthValidator(8, 8) ] )
        ];
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<Permit>(
            (etBuilder) => {

                etBuilder.HasIndex(p => p.Reference).IsUnique();

                etBuilder.Property(p => p.Enabled).IsRequired();

                etBuilder.Property<long>("SolutionShadow").HasColumnName("Solution").IsRequired();
                etBuilder.Property<long>("FeatureShadow").HasColumnName("Feature").IsRequired();
                etBuilder.Property<long>("ActionShadow").HasColumnName("Action").IsRequired();
                etBuilder.HasIndex("ActionShadow", "SolutionShadow", "FeatureShadow")
                    .IsUnique();
                etBuilder
                    .HasOne(p => p.Solution)
                    .WithMany(s => s.Permits)
                    .HasForeignKey("SolutionShadow")
                    .IsRequired();
                
                etBuilder
                    .HasOne(p => p.Feature)
                    .WithMany(f => f.Permits)
                    .HasForeignKey("FeatureShadow")
                    .IsRequired();

                etBuilder
                    .HasOne(p => p.Action)
                    .WithMany(a => a.Permits)
                    .HasForeignKey("ActionShadow")
                    .IsRequired();
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