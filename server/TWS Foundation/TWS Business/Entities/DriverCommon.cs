using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class DriverCommon
    : BBusinessEntity {

    public int Status { get; set; }

    public string License { get; set; } = null!;

    public int? Situation { get; set; }

    public virtual Situation? SituationNavigation { get; set; }

    public virtual Status? StatusNavigation { get; set; }

    /// <summary>
    ///     <see cref="Driver"/> information.
    /// </summary>
    public Driver? Internal { get; set; }

    /// <summary>
    ///     <see cref="DriverExternal"/> information.
    /// </summary>
    public DriverExternal? External { get; set; }


    #region Custom Getters 

    /// <summary>
    ///     Gets the [Driver] displayable name.
    /// </summary>
    /// <remarks>
    ///     Needs loaded <see cref="Internal"/> then <see cref="Driver.Employee"/> then <see cref="Employees.Employee.Identification"/>.
    ///     Needs loaded <see cref="External"/> then <see cref="DriverExternal.Identification"/>.
    /// </remarks>
    public string? Name {
        get {
            Identification? ident;

            if(Internal != null) {
                ident = Internal.Employee?.Identification;
            } else {
                ident = External?.Identification;
            }

            if(ident == null)
                return null;

            return $"{ident.Name} {ident.FatherLastname} {ident.MotherLastName}";
        }
    }

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
                .. Container,
            (nameof(License), [Required, new LengthValidator(8,12)]),
            (nameof(Status), [new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<DriverCommon>(Entity => {
            Entity.HasKey(e => e.Id);
            Entity.ToTable("Drivers_Commons");

            Entity.Property(e => e.Id)
                 .HasColumnName("id");

            Entity.Property(e => e.Timestamp)
                .HasColumnType("datetime");

            Entity.Property(e => e.License)
                .HasMaxLength(12)
                .IsUnicode(false);

            Entity.HasOne(d => d.StatusNavigation)
                .WithMany(p => p.DriversCommons)
                .HasForeignKey(d => d.Status)
                .OnDelete(DeleteBehavior.ClientSetNull);

            Entity.HasOne(d => d.SituationNavigation)
                .WithMany(p => p.DriversCommons)
                .HasForeignKey(d => d.Situation)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });
    }
}
