using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Employee
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.Now;

    public int Status { get; set; }

    public int Identification { get; set; }

    public int? Address { get; set; }

    public int? Approach { get; set; }

    public string? Curp { get; set; }

    public DateOnly? AntecedentesNoPenaleseExp { get; set; }

    public string? Rfc { get; set; }

    public string? Nss { get; set; }

    public DateOnly? IMSSRegistrationDate { get; set; }

    public DateOnly? HiringDate { get; set; }

    public DateOnly? TerminationDate { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Approach? ApproachNavigation { get; set; }

    public virtual Address? AddressNavigation { get; set; }

    public virtual Identification? IdentificationNavigation { get; set; }

    public virtual ICollection<Driver> Drivers { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Identification), [new PointerValidator(true)]),
            (nameof(Status), [new PointerValidator(true)]),
            (nameof(Curp), [new LengthValidator(Min: 18, Max:18, nulleable: true)]),
            (nameof(Rfc), [new LengthValidator(Min: 12, Max:12, nulleable: true)]),
            (nameof(Nss), [new LengthValidator(Min: 11, Max:11, nulleable: true)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Employee>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Employees");

            Entity.Property(e => e.Id)
                 .HasColumnName("id");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Curp)
               .HasColumnName("CURP");
            Entity.Property(e => e.Curp)
                .HasMaxLength(32)
                .IsUnicode(false);

            Entity.Property(e => e.Rfc)
               .HasColumnName("RFC");
            Entity.Property(e => e.Rfc)
                .HasMaxLength(32)
                .IsUnicode(false);

            Entity.Property(e => e.Nss)
               .HasColumnName("NSS");
            Entity.Property(e => e.Nss)
                .HasMaxLength(32)
                .IsUnicode(false);

            Entity.HasOne(d => d.IdentificationNavigation)
             .WithMany(p => p.Employees)
             .HasForeignKey(d => d.Identification);

            Entity.HasOne(d => d.ApproachNavigation)
              .WithMany(p => p.Employees)
              .HasForeignKey(d => d.Approach);

            Entity.HasOne(d => d.AddressNavigation)
                .WithMany(p => p.Employees)
                .HasForeignKey(d => d.Address);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Employees)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
