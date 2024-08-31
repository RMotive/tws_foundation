using System.Reflection.Emit;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;


public class AccountProfile {
    public required int Account { get; init; }
    public required int Profile { get; init; }

    public virtual Account AccountNavigation { get; init; } = null!;
    public virtual Profile ProfileNavigation { get; init; } = null!;

    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<AccountProfile>(entity => {
            entity.ToTable("Accounts_Profiles");
            entity.HasNoKey();

            entity.Property(e => e.Account);
            entity.Property(e => e.Profile);

            entity.HasOne(d => d.AccountNavigation)
                .WithMany()
                .HasForeignKey(d => d.Account)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.ProfileNavigation)
                .WithMany()
                .HasForeignKey(d => d.Profile)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
