using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

namespace TWS_Security.Sets;

public partial class Solution 
    : BDatabaseSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public string Name { get; set; } = null!;

    public string Sign { get; set; } = null!;

    public string? Description { get; set; }

    public virtual ICollection<Permit> Permits { get; set; } = [];

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Name), [new UniqueValidator(), new LengthValidator(1, 40)]),
            (nameof(Sign), [new UniqueValidator(), new LengthValidator(5, 5)]),
        ];
        return Container;
    }
}
