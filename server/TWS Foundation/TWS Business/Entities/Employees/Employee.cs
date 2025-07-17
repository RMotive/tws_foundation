using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;

using CSM_Security.Entities;

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
    [StringLength(18, MinimumLength = 18)]
    public string? CURP { get; set; }

    /// <summary>
    ///     Mexico's unique taxpayer identifier (Registro Federal de Contribuyentes / Federal Taxpaying Registry).
    /// </summary>
    [StringLength(13, MinimumLength = 13)]
    public string? RFC { get; set; } = null!;

    /// <summary>
    ///     Mexico's unqiue people social security identifier (Número de Seguro Social / Social Security Number.)
    /// </summary>
    [StringLength(11, MinimumLength = 11)]
    public string? NSS { get; set; } = null!;

    /// <summary>
    ///     Shadow property pointing Account column since EF doesn't support cross-database references. With this manually populate <see cref="Account"/> 
    ///     object querying [CSM Security] database.
    /// </summary>
    public long? AccountShadow { get; set; }

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
    
    /// <summary>
    ///     <see cref="CSM_Security.Entities.Account"/> information.
    /// </summary>
    [NotMapped]
    public Account? Account { get; set; }

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(CURP)).HasMaxLength(18);
        etBuilder.Property(nameof(RFC)).HasMaxLength(13);
        etBuilder.Property(nameof(NSS)).HasMaxLength(11);

        etBuilder.Property(nameof(AccountShadow)).HasColumnName("Account");

        etBuilder.HasIndex(nameof(AccountShadow)).IsUnique();

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
