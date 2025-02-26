using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Entities;

public class  Driver
    : BBusinessEntity {

    public int Status { get; set; }

    public Employee Employee { get; set; } = default!;

    public int Common { get; set; }

    public string? DriverType { get; set; }

    public DateOnly? LicenseExpiration { get; set; }

    public DateOnly? DrugalcRegistrationDate { get; set; }

    public DateOnly? PullnoticeRegistrationDate { get; set; }

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

    public virtual ICollection<YardLog> YardLogs { get; set; } = [];


    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Status), [new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<Driver>(Entity => {

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

            Entity.HasIndex(e => e.Common)
               .IsUnique();

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Drivers)
                .HasForeignKey(d => d.Status);
        });
    }
}
