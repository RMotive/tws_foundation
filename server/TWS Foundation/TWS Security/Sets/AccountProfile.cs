using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;


public class AccountProfile {

    public int Account { get; init; }

    public int Profile { get; init; }

    public virtual Account? AccountNavigation { get; set; }

    public virtual Profile? ProfileNavigation { get; set; }

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<AccountProfile>(entity => {
            entity.ToTable("Accounts_Profiles");

            entity.Property(e => e.Account);
            entity.Property(e => e.Profile);

            entity.HasKey(i => new { i.Account, i.Profile });

            entity.HasOne(d => d.AccountNavigation)
                .WithMany(p => p.AccountProfiles)
                .HasForeignKey(d => d.Account)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.ProfileNavigation)
                .WithMany(p => p.AccountProfiles)
                .HasForeignKey(d => d.Profile)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
