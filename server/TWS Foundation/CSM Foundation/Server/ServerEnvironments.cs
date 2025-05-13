namespace CSM_Foundation.Server;

/// <summary>
///     <see langword="enum"/> for <see cref="ServerEnvironments"/>.
///     
///     <para>
///         Stores the available {CSM} internal supported enviornments for {Server} solutions.
///     </para>
/// </summary>
public enum ServerEnvironments {
    /// <summary>
    ///     Environment used commonly for development purposes.
    /// </summary>
    development,
    /// <summary>
    ///     Environment used only at production purpose (high risk). 
    /// </summary>
    production,
    /// <summary>
    ///     Environment used for benchmarking tests purposes.
    /// </summary>
    benchmark,
    /// <summary>
    ///     Environment used for pre-production quality assurance purposes.
    /// </summary>
    staging,
    /// <summary>
    ///     Environment used for local/remote batch automatic tests run purposes.
    /// </summary>
    quality,
}