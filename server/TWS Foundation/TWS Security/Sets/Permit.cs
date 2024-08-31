using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;
using System.Text.Json.Serialization;

namespace TWS_Security.Sets;

public partial class Permit 
    : BDatabaseSet {
    public override int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public int Solution { get; set; }

    public string Reference { get; set; } = null!;

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            .. Container,
            (nameof(Name), [new UniqueValidator(), new LengthValidator(1, 50)]),
        ];

        return Container;
    }

    [JsonIgnore]
    public virtual Solution? SolutionNavigation { get; set; }
}
