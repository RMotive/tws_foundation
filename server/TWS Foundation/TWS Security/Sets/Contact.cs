using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Validators;

namespace TWS_Security.Sets;

public partial class Contact 
    : BDatabaseSet {
    public override int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Lastname { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public virtual Account? Account { get; set; }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {

        RequiredValidator Required = new();

        Container = [
                ..Container,
                (nameof(Name), [Required, new LengthValidator(1,50)]),
                (nameof(Lastname), [Required, new LengthValidator(1,50)]),
                (nameof(Email), [Required, new UniqueValidator(),new LengthValidator(1,30)]),
                (nameof(Phone), [Required, new UniqueValidator(), new LengthValidator(10,14)]),

            ];

        return Container;
    }
}
