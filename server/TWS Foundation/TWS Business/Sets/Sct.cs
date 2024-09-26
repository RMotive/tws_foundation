using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Sets;

public partial class Sct
    : BSet {
    public override int Id { get; set; }

    public override DateTime Timestamp { get; set; } = DateTime.UtcNow;

    public int Status { get; set; }

    public string Type { get; set; } = null!;

    public string Number { get; set; } = null!;

    public string Configuration { get; set; } = null!;
    public virtual Status? StatusNavigation { get; set; }

    public virtual ICollection<Carrier> Carriers { get; set; } = [];

    public virtual ICollection<SctH> SctsH { get; set; } = [];


    public static void CreateModel(ModelBuilder Builder) {
        Builder.Entity<Sct>(Entity => {
            Entity.ToTable("SCT");
            Entity.HasKey(e => e.Id);


            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.Id)
               .HasColumnName("id");

            Entity.Property(e => e.Configuration)
                .HasMaxLength(10)
                .IsUnicode(false);
            Entity.Property(e => e.Number)
                .HasMaxLength(25)
                .IsUnicode(false);
            Entity.Property(e => e.Type)
                .HasMaxLength(6)
                .IsUnicode(false);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.Scts)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        Container = [
            ..Container,
            (nameof(Type), [Required, new LengthValidator(6,6)]),
            (nameof(Number), [Required, new LengthValidator(25,25)]),
            (nameof(Configuration), [Required, new LengthValidator(6,10)]),
            (nameof(Status), [Required, new PointerValidator(true)]),

        ];
        return Container;
    }
}
