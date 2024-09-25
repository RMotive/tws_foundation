using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

namespace TWS_Security.Sets;

public partial class Account
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public string User { get; set; } = null!;

    public byte[] Password { get; set; } = null!;

    public bool Wildcard { get; set; }

    public int Contact { get; set; }

    public virtual Contact? ContactNavigation { get; set; } = null!;

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
