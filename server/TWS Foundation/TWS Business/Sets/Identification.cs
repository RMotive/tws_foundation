using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Identification
    : BSet {
    

    

    public int Status { get; set; }

    public string FatherLastname { get; set; } = null!;

    public string MotherLastName { get; set; } = null!;

    public DateOnly? Birthday { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<DriverExternal> DriversExternals { get; set; } = [];

    public virtual ICollection<Employee> Employees { get; set; } = [];


    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<Identification>(Entity => {
            Entity.ToTable("Identifications");
            Entity.HasKey(e => e.Id);

            Entity.Property(e => e.Id)
                .HasColumnName("id");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Name)
                .HasMaxLength(32)
                .IsUnicode(false);

            Entity.Property(e => e.FatherLastname)
                .HasMaxLength(32)
                .IsUnicode(false);

            Entity.Property(e => e.MotherLastName)
                .HasMaxLength(32)
                .IsUnicode(false);

            Entity.HasOne(d => d.StatusNavigation)
               .WithMany(p => p.Identifications)
               .HasForeignKey(d => d.Status)
               .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        Container = [
            ..Container,
            (nameof(Name), [Required, new LengthValidator(Max: 32)]),
            (nameof(FatherLastname), [Required, new LengthValidator(Max: 32)]),
            (nameof(MotherLastName), [Required, new LengthValidator(Max: 32)]),
            (nameof(Status), [new PointerValidator(true)])
        ];
        return Container;
    }
}
