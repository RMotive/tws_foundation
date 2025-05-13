namespace CSM_Foundation.Server.Scheming;

/// <summary>
///     <see langword="interface"/> for <see cref="IResponseSchema{TContent}"/>.
///     
///     <para>
///         Inherits concept from <see cref="IResponseSchema"/> and defines required behavior for a {Server} {Response} {Schema} with a format response content object.
///     </para>
/// </summary>
/// <typeparam name="TContent">
///     Type of the {Server} response main {Content} object.
/// </typeparam>
public interface IResponseSchema<TContent>
    : IResponseSchema {

    /// <summary>
    ///     Response content object.
    /// </summary>
    public TContent Content { get; }
}

/// <summary>
///     <see langword="interface"/> for <see cref="IResponseSchema"/>.
///     
///     <para>
///         Specifies required behavior to indicate the correct functionallity for a {Server} response {Schema} wich is the task to format the {Controller} / {Service} response and transaction scope
///         metadata in a {model} object based on an specific format wrapping actual {response}.
///     </para>
/// </summary>
public interface IResponseSchema {

    /// <summary>
    ///     Server transaction identifier.
    /// </summary>
    public Guid Id { get; }
}