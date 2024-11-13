using System.Reflection.Emit;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;

public partial class ProfilePermit {
    public int Permit { get; set; }

    public int Profile { get; set; }

    public virtual Permit PermitNavigation { get; set; } = null!;

    public virtual Profile ProfileNavigation { get; set; } = null!;


    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<ProfilePermit>(
            (Entity )=> {
                Entity.HasNoKey();
                Entity.ToTable("Profiles_Permits");

                Entity.Property(e => e.Permit)
                    .IsRequired();
                Entity.Property(e => e.Profile)
                    .IsRequired();

                Entity.HasIndex(i => new { i.Profile, i.Permit })
                    .IsUnique();

                Entity.HasOne(d => d.PermitNavigation)
                    .WithMany()
                    .HasForeignKey(d => d.Permit)
                    .OnDelete(DeleteBehavior.ClientSetNull);

                Entity.HasOne(d => d.ProfileNavigation)
                    .WithMany()
                    .HasForeignKey(d => d.Profile)
                    .OnDelete(DeleteBehavior.ClientSetNull);
            }   
        );
    }
}
