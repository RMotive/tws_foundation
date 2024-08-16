using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

namespace TWS_Security.Sets;

public partial class Solution
    : BDatabaseSet {

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Name), [new UniqueValidator(), new LengthValidator(1, 40)]),
            (nameof(Sign), [new UniqueValidator(), new LengthValidator(5, 5)]),
        ];
        return Container;
    }
}
