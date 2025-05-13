namespace CSM_Foundation.Server;

/// <summary>
///     {model} record for <see cref="ExceptionInfo"/>.
///     
///     <para>
///         Stores public information to expose an Exception details.
///     </para>
/// </summary>
public record ExceptionInfo {
    /// <summary>
    ///     Where the exception got thrown.
    /// </summary>
    public required string Trace { get; init; }

    /// <summary>
    ///     Specific exception management situation code.
    /// </summary>
    public required int Situation { get; init; }

    /// <summary>
    ///     User friendly displayable error message.
    /// </summary>
    public required string Advise { get; init; }

    /// <summary>
    ///     Exception message caught at system level.
    /// </summary>
    public required string System { get; init; }

    /// <summary>
    ///     Additional detailed information about the exception.
    /// </summary>
    public Dictionary<string, dynamic> Factors { get; init; } = [];
}
