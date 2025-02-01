using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;

public partial class Account
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public string User { get; set; } = null!;

    public byte[] Password { get; set; } = null!;

    public bool Wildcard { get; set; }

    public int Contact { get; set; }

    public virtual Contact? ContactNavigation { get; set; } = null!;

    public virtual ICollection<AccountPermit> AccountPermits { get; set; } = [];

    public virtual ICollection<AccountProfile> AccountProfiles { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(User), [new UniqueValidator(), new RequiredValidator(), new LengthValidator(Min: 1, Max: 50)]),
            (nameof(Password), [ new RequiredValidator() ]),
            (nameof(Contact), [new PointerValidator(true, false)]),
        ];
        return Container;
    }
    public static void CreateModel(ModelBuilder Builder) {

        Builder.Entity<Account>(entity => {
            entity.HasKey(e => e.Id);

            entity.HasIndex(e => e.User).IsUnique();

            entity.HasIndex(e => e.Contact).IsUnique();

            entity.Property(e => e.Id);
            entity.Property(e => e.Password);
            entity.Property(e => e.User)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.ContactNavigation).WithOne(p => p.Account)
                 .HasForeignKey<Account>(d => d.Contact)
                 .OnDelete(DeleteBehavior.ClientSetNull);

        });
    }

}
