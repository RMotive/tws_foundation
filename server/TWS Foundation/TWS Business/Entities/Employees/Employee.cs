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
    public Identification Identification { get; set; } = default!;

    /// <summary>
    ///     Status information.
    /// </summary>
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     Important <see cref="Employee"/> dates information.
    /// </summary>
    public Employee_Dates Dates { get; set; } = default!;

    /// <summary>
    ///     Approaching contact information.
    /// </summary>
    public Approach? Approach { get; set; }

    /// <summary>
    ///     Address information.
    /// </summary>
    public Address? Address { get; set; }

    protected override void DescribeSet(ModelBuilder ModelBuilder) {
        ModelBuilder.Entity(
                (EntityTypeBuilder<Employee> etBuilder) => {
                    etBuilder.Property(e => e.CURP).HasMaxLength(18);
                    etBuilder.Property(e => e.RFC).HasMaxLength(13);
                    etBuilder.Property(e => e.NSS).HasMaxLength(11);

                    etBuilder
                        .HasOne(e => e.Identification)
                        .WithOne(i => i.Employee)
                        .HasForeignKey<Employee>("IdentificationShadow")
                        .IsRequired();
                    etBuilder.Property<int>("IdentificationShadow").HasColumnName("Identification");

                    etBuilder
                        .HasOne(e => e.Status)
                        .WithMany(s => s.Employees)
                        .HasForeignKey("StatusShadow")
                        .IsRequired();
                    etBuilder.Property<int>("StatusShadow").HasColumnName("Status");

                    etBuilder
                        .HasOne(e => e.Dates)
                        .WithOne(ed => ed.Employee)
                        .HasForeignKey<Employee>("DatesShadow")
                        .IsRequired();
                    etBuilder.Property<long>("DatesShadow").HasColumnName("Dates").HasColumnType("bigint");

                    etBuilder
                        .HasOne(e => e.Address)
                        .WithMany(a => a.Employees)
                        .HasForeignKey("AddressShadow");
                    etBuilder.Property<long>("AddressShadow").HasColumnName("Address");

                    etBuilder
                        .HasOne(e => e.Approach)
                        .WithMany(a => a.Employees)
                        .HasForeignKey("ApproachShadow");
                    etBuilder.Property<long>("ApproachShadow").HasColumnName("Approach");
                }
            );
    }
}
