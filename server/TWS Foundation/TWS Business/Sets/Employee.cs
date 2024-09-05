using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Employee
    : BDatabaseSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public int Status { get; set; }

    public int Identification { get; set; }

    public int Address { get; set; }

    public int Approach { get; set; }

    public string Curp { get; set; } = null!;

    public DateOnly AntecedentesNoPenaleseExp { get; set; }

    public string Rfc { get; set; } = null!;

    public string Nss { get; set; } = null!;

    public DateOnly IMSSRegistrationDate { get; set; }

    public DateOnly? HiringDate { get; set; }

    public DateOnly? TerminationDate { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Approach? ApproachNavigation { get; set; }

    public virtual Address? AddressNavigation { get; set; }

    public virtual Identification? IdentificationNavigation { get; set; }

    public virtual ICollection<Driver> Drivers { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(Identification), [new PointerValidator(true)]),
            (nameof(Approach), [new PointerValidator(true)]),
            (nameof(Address), [new PointerValidator(true)]),
            (nameof(Status), [new PointerValidator(true)]),
            (nameof(Curp), [Required, new LengthValidator(18)]),
            (nameof(Rfc), [Required, new LengthValidator(12)]),
            (nameof(Nss), [Required, new LengthValidator(11)]),
        ];

        return Container;
    }

    public static void Set(ModelBuilder builder) {
        builder.Entity<Employee>(entity => {
            entity.HasKey(e => e.Id);
            entity.ToTable("Employees");

            entity.Property(e => e.Id)
                 .HasColumnName("id");

            entity.Property(e => e.Curp)
               .HasColumnName("CURP");
            entity.Property(e => e.Curp)
                .HasMaxLength(32)
                .IsUnicode(false);

            entity.Property(e => e.Rfc)
               .HasColumnName("RFC");
            entity.Property(e => e.Rfc)
                .HasMaxLength(32)
                .IsUnicode(false);

            entity.Property(e => e.Nss)
               .HasColumnName("NSS");
            entity.Property(e => e.Nss)
                .HasMaxLength(32)
                .IsUnicode(false);

            entity.HasOne(d => d.IdentificationNavigation)
             .WithMany(p => p.Employees)
             .HasForeignKey(d => d.Identification);

            entity.HasOne(d => d.ApproachNavigation)
              .WithMany(p => p.Employees)
              .HasForeignKey(d => d.Approach);

            entity.HasOne(d => d.AddressNavigation)
                .WithMany(p => p.Employees)
                .HasForeignKey(d => d.Address);

            entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Employees)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
