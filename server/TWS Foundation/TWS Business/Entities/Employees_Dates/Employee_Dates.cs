using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Entities.Employees_Dates;

public class Employee_Dates
    : BEntity {
    public override Type Database { get; init; } = typeof(BusinessDatabase);

    /// <summary>
    ///     When the (Certificado de No Antecedentes Penales / Certificate of No Criminal Records) was issued.
    /// </summary>
    public DateOnly? CNAP { get; set; }

    /// <summary>
    ///     When was the <see cref="Employees.Employee"/> issued to the ( Instituto Méxicano del Seguro Social / Mexican Social Security Institute).
    /// </summary>
    public DateOnly? IMSS { get; set; }

    /// <summary>
    ///     Hiring date.
    /// </summary>
    public DateOnly? Hire { get; set; }

    /// <summary>
    ///     Laboral relation termination date.
    /// </summary>
    public DateOnly? Termination { get; set; }

    /// <summary>
    ///     <see cref="Employees.Employee"/> information.
    /// </summary>
    public Employee Employee { get; set; } = default!;

    protected override void DescribeSet(ModelBuilder Builder) {
        Builder.Entity(
                (EntityTypeBuilder<Employee_Dates> EntityTypeBuilder) => {

                    EntityTypeBuilder.Property(ed => ed.CNAP);
                    EntityTypeBuilder.Property(ed => ed.IMSS);
                    EntityTypeBuilder.Property(ed => ed.Hire);
                    EntityTypeBuilder.Property(ed => ed.Termination);
                }
            );
    }
}
