using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;

namespace TWS_Security.Sets;

public partial class AccountPermit {

    public int Account { get; set; }

    public int Permit { get; set; }

    public virtual Account? AccountNavigation { get; set; }

    public virtual Permit? PermitNavigation { get; set; }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<AccountPermit>(entity => {
            entity.ToTable("Accounts_Permits");

            entity.Property(e => e.Account)
                .IsRequired();
            entity.Property(e => e.Permit)
                .IsRequired();

            entity.HasKey(i => new { i.Account, i.Permit });

            entity.HasOne(d => d.AccountNavigation)
                .WithMany(p => p.AccountPermits)
                .HasForeignKey(d => d.Account)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.PermitNavigation)
                .WithMany(p => p.AccountPermits)
                .HasForeignKey(d => d.Permit)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
