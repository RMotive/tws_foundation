using System.ComponentModel.DataAnnotations;

using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;

namespace TWS_Business.Entities.Drivers;

/// <summary>
///     [Entity] that represent common information for [Drivers] (<see cref="Driver"/> / <see cref="DriverExternal"/>).
/// </summary>
public class Driver_Common
    : BCommonEntity<Driver, DriverExternal> {

    #region Properties

    /// <summary>
    ///     Licence identification number.
    /// </summary>
    [StringLength(12, MinimumLength = 8)]
    public string License { get; set; } = null!;

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    [EntityDependant("Status", typeof(Status))]
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Situation"/> information.
    /// </summary>
    [EntityDependant("Situation", typeof(Situation))]
    public Situation? Situation { get; set; } = default!;

    #endregion

    #region dependants

    /// <summary>
    ///     <see cref="YardLog"/> dependants from this <see cref="YardLog"/>.
    /// </summary>
    [EntityDependency("Yardlogs", typeof(YardLog), isCollection:true)]
    public ICollection<YardLog> Yardlogs { get; set; } = [];

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

            if (ident.SecondLastname != null) return $"{ident.Name} {ident.FirstLastname} {ident.SecondLastname}";

            return $"{ident.Name} {ident.FirstLastname}";
        }
    }

    #endregion

    protected override void DesignCommonEntity(EntityTypeBuilder etBuilder) {

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
