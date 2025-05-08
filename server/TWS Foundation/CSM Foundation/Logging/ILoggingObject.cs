namespace CSM_Foundation.Logging;

/// <summary>
///     <see langword="interface"/> for <see cref="ILoggingObject"/>.
///     
///     <para> Defines a contract for <see cref="ILoggingObject"/> implementations that defines special members for an <see langword="object"/> to simplify logging engine </para>
/// </summary>
public interface ILoggingObject {

    /// <summary>
    ///     Logs the current <see langword="object"/> information.
    /// </summary>
    /// <returns>
    ///     A {CSM} Logging engine readable information <see langword="object"/>.
    /// </returns>
    public Dictionary<string, object?> Log();
}
