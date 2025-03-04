using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Approaches;

namespace TWS_Business.Entities;

public partial class CarrierH
    : BBusinessEntity {

    [StringLength(100)]
    public string Name { get; set; } = string.Empty;

    public int Sequence { get; set; }

    public int Status { get; set; }

    public int Entity { get; set; }

    public int? ApproachH { get; set; }


    public int Address { get; set; }

    public int? UsdotH { get; set; }

    public int? SctH { get; set; }

    public virtual Carrier? CarrierNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Approach_History? ContactHNavigation { get; set; }

    public virtual Address? AddressNavigation { get; set; }

    public virtual UsdotH? UsdotHNavigation { get; set; }

    public virtual SctH? SctHNavigation { get; set; }

    /// <summary>
    ///     <see cref="TruckH"/> entries referencing this <see cref="CarrierH"/>.
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

    protected override void DesignEntity(ModelBuilder Builder) {
        Builder.Entity<CarrierH>(Entity => {
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
        });
    }
}
