using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Employees_Dates;

namespace TWS_Business.Entities.Employees;

public class Employee
    : BBusinessEntity {

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

    /// <summary>
    ///     Identification information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Identification Identification { get; set; } = default!;

    /// <summary>
    ///     Status information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     Important <see cref="Employee"/> dates information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Employee_Dates Dates { get; set; } = default!;

    /// <summary>
    ///     Approaching contact information.
    /// </summary>
    public Approach? Approach { get; set; }

    /// <summary>
    ///     Address information.
    /// </summary>
    public Address? Address { get; set; }

    /// <summary>
    ///     <see cref="Entities.Driver"/> information.
    /// </summary>
    public Driver? Driver { get; set; }

    protected override void DescribeSet(ModelBuilder ModelBuilder) {
        ModelBuilder.Entity(
                (EntityTypeBuilder<Employee> etBuilder) => {
                    etBuilder.Property(e => e.CURP).HasMaxLength(18);
                    etBuilder.Property(e => e.RFC).HasMaxLength(13);
                    etBuilder.Property(e => e.NSS).HasMaxLength(11);

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
            );
    }
}
