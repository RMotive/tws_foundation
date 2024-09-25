using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Driver
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.Now;

    public int Status { get; set; }

    public int Employee { get; set; }

    public int Common { get; set; }

    public string DriverType { get; set; } = null!;

    public DateOnly LicenseExpiration { get; set; }

    public DateOnly DrugalcRegistrationDate { get; set; }

    public DateOnly PullnoticeRegistrationDate { get; set; }

    public string? Twic { get; set; }

    public DateOnly? TwicExpiration { get; set; }

    public string? Visa { get; set; }

    public DateOnly? VisaExpiration { get; set; }

    public string? Fast { get; set; }

    public DateOnly? FastExpiration { get; set; }

    public string? Anam { get; set; }

    public DateOnly? AnamExpiration { get; set; }

    public virtual DriverCommon? DriverCommonNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual Employee? EmployeeNavigation { get; set; }

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Status), [new PointerValidator(true)]),
            (nameof(Employee), [new PointerValidator(true)]),
            (nameof(DriverType), [new UniqueValidator(), new LengthValidator(1,12)]),
        ];

        return Container;
    }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Driver>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Drivers");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.DriverType)
                .HasMaxLength(12)
                .IsUnicode(false);

            Entity.Property(e => e.Twic)
               .HasColumnName("TWIC");
            Entity.Property(e => e.Twic)
                .HasMaxLength(12)
                .IsUnicode(false);

            Entity.Property(e => e.Visa)
               .HasColumnName("VISA");
            Entity.Property(e => e.Visa)
                .HasMaxLength(12)
                .IsUnicode(false);

            Entity.Property(e => e.Fast)
               .HasColumnName("FAST");
            Entity.Property(e => e.Fast)
                .HasMaxLength(12)
                .IsUnicode(false);

            Entity.Property(e => e.Anam)
               .HasColumnName("ANAM");
            Entity.Property(e => e.Anam)
                .HasMaxLength(24)
                .IsUnicode(false);

            Entity.HasOne(d => d.DriverCommonNavigation)
                .WithMany(p => p.Drivers)
                .HasForeignKey(d => d.Common);

            Entity.HasIndex(e => e.Common)
               .IsUnique();

            Entity.HasOne(d => d.EmployeeNavigation)
                .WithMany(p => p.Drivers)
                .HasForeignKey(d => d.Employee);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Drivers)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
