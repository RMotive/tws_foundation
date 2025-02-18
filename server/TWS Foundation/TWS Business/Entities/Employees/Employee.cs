using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Entities.Employees;

public class Employee
    : BBusinessDatabaseEntity {

    public int Status { get; set; }
    public Status? Status_ { get; set; }

    public int? Approach { get; set; }
    public Approach? Approach_ { get; set; }

    public int Identification { get; set; }
    public Identification? IdentificationNavigation { get; set; }

    public int? Address { get; set; }

    public string? Curp { get; set; } = null!;

    public DateOnly? AntecedentesNoPenaleseExp { get; set; }

    public string? Rfc { get; set; } = null!;

    public string? Nss { get; set; } = null!;

    public DateOnly? IMSSRegistrationDate { get; set; }

    public DateOnly? HiringDate { get; set; }

    public DateOnly? TerminationDate { get; set; }

    public virtual Address? AddressNavigation { get; set; }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Identification), [new PointerValidator(true)]),
            (nameof(Status), [new PointerValidator(true)]),
        ];

        return Container;
    }

    protected override void DescribeSet(ModelBuilder Builder) {

    }
}
