using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Entities;

public class Driver
    : BBusinessEntity<DriverCommon> {

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

    /// <summary>
    ///     <see cref="Employees.Employee"/> information.
    /// </summary>
    public Employee Employee { get; set; } = default!;

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity<Driver>(
            (Entity) => {
                Entity.Property(e => e.DriverType).HasMaxLength(12);
                Entity.Property(e => e.TWIC).HasMaxLength(12);
                Entity.Property(e => e.VISA).HasMaxLength(12);
                Entity.Property(e => e.Fast).HasMaxLength(12);
                Entity.Property(e => e.ANAM).HasMaxLength(24);

                Entity.Link<Driver, Employee>(
                        nameof(Employee),
                        Required: true,
                        Auto: true,
                        Index: true
                    );
            }
        );
    }
}
