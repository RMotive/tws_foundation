using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities;

public partial class DriverCommon
    : BBusinessEntity {

    /// <summary>
    ///     Licence identification number.
    /// </summary>
    [StringLength(12, MinimumLength = 8)]
    public string License { get; set; } = null!;

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>
    public Situation Situation { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    public Status Status { get; set; } = default!;

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

            if (Internal != null) {
                ident = Internal.Employee?.Identification;
            } else {
                ident = External?.Identification;
            }

            if (ident == null)
                return null;

            return $"{ident.Name} {ident.FatherLastname} {ident.MotherLastName}";
        }
    }

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        RequiredValidator Required = new();

        Container = [
            ..Container,
            (nameof(License), [ Required, new LengthValidator(8, 12)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder mBuilder) {
        mBuilder.Entity<DriverCommon>(
            (etBuilder) => {
                etBuilder.ToTable("Drivers_Commons");

                etBuilder.Property(e => e.License).HasMaxLength(12);

                etBuilder.Link<DriverCommon, Situation>(
                        nameof(Situation),
                        nameof(Situation.Drivers),
                        Required: true,
                        Auto: true
                    );
                etBuilder.Link<DriverCommon, Status>(
                        nameof(Status),
                        nameof(Situation.Drivers),
                        Required: true,
                        Auto: true
                    );
            }
        );
    }
}
