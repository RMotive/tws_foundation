using System.Reflection.Emit;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;

public partial class Contact 
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public string Name { get; set; } = null!;

    public string Lastname { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public virtual Account? Account { get; set; }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        RequiredValidator Required = new();

        Container = [
                ..Container,
                (nameof(Name), [Required, new LengthValidator(1,50)]),
                (nameof(Lastname), [Required, new LengthValidator(1,50)]),
                (nameof(Email), [Required, new UniqueValidator(),new LengthValidator(1,30)]),
                (nameof(Phone), [Required, new UniqueValidator(), new LengthValidator(10,14)]),

            ];

        return Container;
    }


    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Contact>(entity => {
            entity.HasKey(e => e.Id);

            entity.HasIndex(e => e.Phone)
                .IsUnique();

            entity.HasIndex(e => e.Email)
                .IsUnique();

            entity.Property(e => e.Id);
            entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");
            entity.Property(e => e.Email)
                .HasMaxLength(30)
                .IsUnicode(false);
            entity.Property(e => e.Lastname)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Phone)
                .HasMaxLength(14)
                .IsUnicode(false);
        });
    }
}
