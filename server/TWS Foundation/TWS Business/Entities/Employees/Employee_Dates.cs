using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities.Employees;

/// <summary>
///     [Entity] that stores dates of interest for <see cref="Employee"/> entities.
/// </summary>
public class Employee_Dates
    : TWSEntity {

    #region Properties

    /// <summary>
    ///     When the (Certificado de No Antecedentes Penales / Certificate of No Criminal Records) was issued.
    /// </summary>
    public DateOnly? CNAP { get; set; }

    /// <summary>
    ///     When was the <see cref="Employee"/> issued to the ( Instituto Méxicano del Seguro Social / Mexican Social Security Institute).
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

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(CNAP));
        etBuilder.Property(nameof(IMSS));
        etBuilder.Property(nameof(Hire));
        etBuilder.Property(nameof(Termination));
    }
}
