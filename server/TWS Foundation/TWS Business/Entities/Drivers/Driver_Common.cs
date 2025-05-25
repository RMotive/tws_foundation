using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Drivers;

/// <summary>
///     [Entity] that represent common information for [Drivers] (<see cref="Driver"/> / <see cref="DriverExternal"/>).
/// </summary>
public class Driver_Common
    : TWSScopeCommonEntity<Driver, DriverExternal> {

    #region Properties

    /// <summary>
    ///     Licence identification number.
    /// </summary>
    [StringLength(12, MinimumLength = 8)]
    public string License { get; set; } = null!;

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>
    [Relation]
    public Situation Situation { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    [Relation]
    public Status Status { get; set; } = default!;

    #endregion

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

            return $"{ident.Name} {ident.Lastname}";
        }
    }

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Drivers_Commons");

        etBuilder.Property(nameof(License)).HasMaxLength(12);

        etBuilder.Link<Driver_Common, Situation>(
                nameof(Situation),
                nameof(Situation.Drivers),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Driver_Common, Status>(
                nameof(Status),
                nameof(Situation.Drivers),
                Required: true,
                Auto: true
            );
    }
}
