using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Approaches;

namespace TWS_Business.Entities;

/// <summary>
///     [History] entity for <see cref="Carrier"/>.
/// </summary>
public class Carrier_History
    : BBusinessHistory<Carrier> {

    #region Properties
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Approaches.Approach"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Approach Approach { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Address"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Address Address { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.USDOT"/> information.
    /// </summary>
    public USDOT? USDOT { get; set; }

    #endregion

    public int Status { get; set; }

    public int? ApproachH { get; set; }


    public int Address { get; set; }

    public int? UsdotH { get; set; }

    public int? SctH { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Approach_History? ContactHNavigation { get; set; }

    public virtual Address? AddressNavigation { get; set; }

    public virtual UsdotH? UsdotHNavigation { get; set; }

    public virtual SctH? SctHNavigation { get; set; }

    /// <summary>
    ///     <see cref="TruckH"/> entries referencing this <see cref="Carrier_History"/>.
    /// </summary>
    public ICollection<TruckH> TrucksHistories { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Name), [Required, new LengthValidator(1, 20)]),
            //(nameof(Approach_History), [Required, new PointerValidator(true)]),
            (nameof(Address), [Required, new PointerValidator(true)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(Entity), [Required, new PointerValidator(true)]),

        ];

        return Container;
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {

        Entity.HasKey(e => e.Id);
        Entity.Property(e => e.Id)
           .HasColumnName("id");
        Entity.ToTable("Carriers_H");

        Entity.Property(e => e.Name)
            .HasMaxLength(20)
            .IsUnicode(false);

        Entity.Property(e => e.Timestamp)
            .HasColumnType("datetime");

        Entity.Property(e => e.ApproachH)
            .HasColumnName("ApproachH");

        Entity.HasOne(d => d.ContactHNavigation)
          .WithMany(p => p.CarriersHistories)
          .HasForeignKey(d => d.ApproachH);

        Entity.HasOne(d => d.CarrierNavigation)
          .WithMany(p => p.Histories)
          .HasForeignKey(d => d.Entity);

        Entity.HasOne(d => d.AddressNavigation)
            .WithMany(p => p.CarriersHistories)
            .HasForeignKey(d => d.Address)
            .OnDelete(DeleteBehavior.ClientSetNull);

        Entity.Property(e => e.UsdotH)
            .HasColumnName("USDOTH");

        Entity.HasOne(d => d.UsdotHNavigation)
           .WithMany(p => p.CarriersH)
           .HasForeignKey(d => d.UsdotH);

        Entity.Property(e => e.SctH)
            .HasColumnName("SCTH");

        Entity.HasOne(d => d.SctHNavigation)
           .WithMany(p => p.CarriersH)
           .HasForeignKey(d => d.SctH);

        Entity.HasOne(d => d.StatusNavigation)
            .WithMany(p => p.CarriersH)
            .HasForeignKey(d => d.Status)
            .OnDelete(DeleteBehavior.ClientSetNull);
    }
}
