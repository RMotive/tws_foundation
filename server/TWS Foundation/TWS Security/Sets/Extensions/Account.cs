using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

namespace TWS_Security.Sets;
public partial class Account
    : BDatabaseSet {

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(User), [ new UniqueValidator(), new RequiredValidator() ]),
            (nameof(Password), [ new RequiredValidator() ]),
            (nameof(Contact), [new PointerValidator(true)]),
        ];
        return Container;
    }
}
