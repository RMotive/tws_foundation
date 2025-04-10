using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Drivers;

namespace TWS_Business.Entities.Employees;

/// <summary>
///     [Entity] that represent a business human being handled by business administration. A legally employee from own administration.
/// </summary>
public class Employee
    : BEntity {

    #region Properties

    /// <summary>
    ///     Mexico's unique people identifier (Clave Única de Registro de Población / Unique Population Registry Code).
    /// </summary>
    public string? CURP { get; set; }

    /// <summary>
    ///     Mexico's unique taxpayer identifier (Registro Federal de Contribuyentes / Federal Taxpaying Registry).
    /// </summary>
    public string? RFC { get; set; } = null!;

    /// <summary>
    ///     Mexico's unqiue people social security identifier (Número de Seguro Social / Social Security Number.)
    /// </summary>
    public string? NSS { get; set; } = null!;

    #endregion

    #region Relations

    /// <summary>
    ///     Identification information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Identification Identification { get; set; } = default!;

    /// <summary>
    ///     Status information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     Important <see cref="Employee"/> dates information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Employee_Dates Dates { get; set; } = default!;

    /// <summary>
    ///     Approaching contact information.
    /// </summary>
    [Relation]
    public Approach? Approach { get; set; }

    /// <summary>
    ///     Address information.
    /// </summary>
    [Relation]
    public Address? Address { get; set; }

    /// <summary>
    ///     <see cref="Drivers.Driver"/> information.
    /// </summary>
    [Relation]
    public Driver? Driver { get; set; }

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(CURP)).HasMaxLength(18);
        etBuilder.Property(nameof(RFC)).HasMaxLength(13);
        etBuilder.Property(nameof(NSS)).HasMaxLength(11);

        etBuilder.Link<Employee, Identification>(
                nameof(Identification),
                Required: true,
                Auto: true,
                Index: true
            );
        etBuilder.Link<Employee, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Employee, Employee_Dates>(
                nameof(Dates),
                Required: true,
                Auto: true,
                Index: true
            );
        etBuilder.Link<Employee, Address>(nameof(Address));
        etBuilder.Link<Employee, Approach>(nameof(Approach));
    }
}
