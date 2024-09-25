using CSM_Foundation.Core.Bases;
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class CarrierH
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Sequence { get; set; }

    public int Status { get; set; }

    public int Entity { get; set; }

    public string Name { get; set; } = null!;

    public int? ApproachH { get; set; }
    

    public int Address { get; set; }

    public int? UsdotH { get; set; }

    public int? SctH { get; set; }

    public virtual Carrier? CarrierNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ApproachesH? ContactHNavigation { get; set; }

    public virtual Address? AddressNavigation { get; set; }

    public virtual UsdotH? UsdotHNavigation { get; set; }

    public virtual SctH? SctHNavigation { get; set; }

    public virtual ICollection<TruckH> TrucksH { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(Name), [Required, new LengthValidator(1, 20)]),
            //(nameof(ApproachesH), [Required, new PointerValidator(true)]),
            (nameof(Address), [Required, new PointerValidator(true)]),
            (nameof(Status), [Required, new PointerValidator(true)]),
            (nameof(Entity), [Required, new PointerValidator(true)]),

        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
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
              .WithMany(p => p.CarriersH)
              .HasForeignKey(d => d.ApproachH);

            Entity.HasOne(d => d.CarrierNavigation)
              .WithMany(p => p.CarriersH)
              .HasForeignKey(d => d.Entity);

            Entity.HasOne(d => d.AddressNavigation)
                .WithMany(p => p.CarriersH)
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
