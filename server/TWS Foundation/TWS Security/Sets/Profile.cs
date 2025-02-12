using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets;

/// <summary>
///     Profile [Set] record object definition.
///     
///     A Profile stores a relation between a collection of <see cref="Permit"/> with an <see cref="Account"/>
/// </summary>
public partial class Profile
    : BSet {
    public override int Id { get; set; }
    public override DateTime Timestamp { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        return [
            ..Container,
            (nameof(Name), [ new LengthValidator(1, 25), new UniqueValidator() ]),
        ];
    }

    protected override void DescribeSet(ModelBuilder Builder) { }
}
