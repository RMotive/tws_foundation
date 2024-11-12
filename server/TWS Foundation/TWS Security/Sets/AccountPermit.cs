using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;

public partial class AccountPermit {

    public int Account { get; set; }
    public virtual Account AccountNavigation { get; init; } = null!;

    public int Permit { get; set; }
    public virtual Permit PermitNavigation { get; init; } = null!;



    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<AccountPermit>(entity => {
            entity.ToTable("Accounts_Permits");
            entity.HasNoKey();

            entity.Property(e => e.Account)
                .IsRequired();
            entity.Property(e => e.Permit)
                .IsRequired();

            entity.HasIndex(i => new { i.Account, i.Permit })
                .IsUnique();

            entity.HasOne(d => d.AccountNavigation)
                .WithMany()
                .HasForeignKey(d => d.Account)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.PermitNavigation)
                .WithMany()
                .HasForeignKey(d => d.Permit)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
