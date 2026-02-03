using System.ComponentModel.DataAnnotations;

using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;
using TWS_Business.Entities.Employees;

namespace TWS_Business.Entities.Drivers;

/// <summary>
///     [Entity] that represents an internal business driver (Tuck operator).
/// </summary>
public class Driver
    : BCommonScopeEntity<Driver_Common> {

    #region Properties

    /// <summary>
    ///     Fast permit number.
    /// </summary>
    [StringLength(12, MinimumLength = 12)]
    public string? Fast { get; set; }

    /// <summary>
    ///     TBD
    /// </summary>
    [StringLength(24, MinimumLength = 24)]
    public string? ANAM { get; set; }

    /// <summary>
    ///     USA Visa document number.
    /// </summary>
    [StringLength(12, MinimumLength = 12)]
    public string? VISA { get; set; }

    /// <summary>
    ///     TBD
    /// </summary>
    [StringLength(12, MinimumLength = 12)]
    public string? TWIC { get; set; }

    /// <summary>
    ///     Driver type name.
    /// </summary>
    [StringLength(12, MinimumLength = 1)]
    public string? DriverType { get; set; }

    /// <summary>
    ///     Driver licence expiration date.
    /// </summary>
    public DateOnly? LicenseExpiration { get; set; }

    /// <summary>
    ///     TBD
    /// </summary>
    public DateOnly? DrugalcRegistrationDate { get; set; }

    /// <summary>
    ///     TBD
    /// </summary>
    public DateOnly? PullnoticeRegistrationDate { get; set; }

    /// <summary>
    ///     TDB
    /// </summary>
    public DateOnly? TwicExpiration { get; set; }

    /// <summary>
    ///     USA Visa expiration date.
    /// </summary>
    public DateOnly? VisaExpiration { get; set; }

    /// <summary>
    ///     Fast permit expiration date.
    /// </summary>
    public DateOnly? FastExpiration { get; set; }

    /// <summary>
    ///     TBD
    /// </summary>
    public DateOnly? AnamExpiration { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Employees.Employee"/> information.
    /// </summary>
    [EntityRelation]
    public Employee Employee { get; set; } = default!;

    #endregion

    protected override void DesignScopeEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(DriverType)).HasMaxLength(12);
        etBuilder.Property(nameof(TWIC)).HasMaxLength(12);
        etBuilder.Property(nameof(VISA)).HasMaxLength(12);
        etBuilder.Property(nameof(Fast)).HasMaxLength(12);
        etBuilder.Property(nameof(ANAM)).HasMaxLength(24);

        etBuilder.Link<Driver, Employee>(
                nameof(Employee),
                Required: true,
                Auto: true,
                Index: true
            );
    }
}
