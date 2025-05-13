namespace CSM_Foundation.Server.Scheming;

/// <summary>
///     {model} record for <see cref="ResponseSchema"/>.
///     
///     <para>
///         Implementation from <see cref="IResponseSchema{TContent}"/>, defines a data model for a default, standard {Server} {Response} {Schema}
///     </para>
/// </summary>
public record ResponseSchema
    : IResponseSchema<Dictionary<string, object?>> {

    public required Guid Id { get; init; }
    
    public required Dictionary<string, object?> Content { get; init; }
}
