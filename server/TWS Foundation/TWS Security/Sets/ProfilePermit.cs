using System.Reflection.Emit;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;

public partial class ProfilePermit {
    public int Permit { get; set; }

    public int Profile { get; set; }

    public virtual Permit PermitNavigation { get; set; } = null!;

    public virtual Profile ProfileNavigation { get; set; } = null!;


    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<ProfilePermit>(entity => {
            entity.HasNoKey();
            entity.ToTable("Profiles_Permits");

            entity.Property(e => e.Permit);
            entity.Property(e => e.Profile);

            entity.HasOne(d => d.PermitNavigation).WithMany()
                .HasForeignKey(d => d.Permit)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.ProfileNavigation).WithMany()
                .HasForeignKey(d => d.Profile)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
