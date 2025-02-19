using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Entities;

public partial class Identification
    : BBusinessDatabaseEntity, IEntity_Name {

    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    public int Status { get; set; }

    public string FatherLastname { get; set; } = null!;

    public string MotherLastName { get; set; } = null!;

    public DateOnly? Birthday { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<DriverExternal> DriversExternals { get; set; } = [];

    public Employee? Employee { get; set; }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<Identification>(Entity => {

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
