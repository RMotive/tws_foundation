using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that represents an internal business driver (Tuck operator).
/// </summary>
public class Driver
    : TWSScopeEntity<DriverCommon> {

    #region Properties

    /// <summary>
    ///     Fast permit number.
    /// </summary>
    public string? Fast { get; set; }

    /// <summary>
    ///     TBD
    /// </summary>
    public string? ANAM { get; set; }

    /// <summary>
    ///     USA Visa document number.
    /// </summary>
    public string? VISA { get; set; }

    /// <summary>
    ///     TBD
    /// </summary>
    public string? TWIC { get; set; }

    /// <summary>
    ///     Driver type name.
    /// </summary>
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
    public Employee Employee { get; set; } = default!;

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
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
