using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class Situation
    : BBusinessEntity, IEntity_Name {

    public string Name { get; set; } = default!;

    public string? Description { get; set; }

    public virtual ICollection<DriverCommon>? DriversCommons { get; set; } = [];

    public virtual ICollection<TruckCommon>? TrucksCommons { get; set; } = [];

    public virtual ICollection<TrailerCommon>? TrailersCommons { get; set; } = [];

    /// <summary>
    ///     <see cref="TruckH"/> history entries referencing this <see cref="Situation"/>
    /// </summary>
    public virtual ICollection<TruckH> TrucksHistories { get; set; } = [];

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<Situation>(Entity => {
            Entity.HasKey(e => e.Id);


            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.HasIndex(e => e.Name)
                .IsUnique();

            Entity.Property(e => e.Id)
                .HasColumnName("id");
            Entity.Property(e => e.Description)
                .HasMaxLength(100);
            Entity.Property(e => e.Name)
                .HasMaxLength(25);
        });
    }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();
        Container = [
            ..Container,
            (nameof(Name), [Required, new LengthValidator(1, 25)]),
        ];
        return Container;
    }
}
