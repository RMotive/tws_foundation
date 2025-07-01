

namespace CSM_Foundation.Logging;

/// <summary>
///     <see langword="interface"/> for <see cref="ILoggingException"/>.
///     
///     <para> Defines a contract for <see cref="ILoggingException"/> implementations that defines special members for an <see cref="Exception"/> to simplify logging engine </para>
/// </summary>
public interface ILoggingException {

    /// <summary>
    ///     Subject of the exception (i.e. Logging Engine Exception).
    /// </summary>
    public string Subject { get; }

    /// <summary>
    ///     Exception visible message.
    /// </summary>
    public string Message { get; }

    /// <summary>
    ///     Message exception caught stack trace description.
    /// </summary>
    public string Trace { get; }

    /// <summary>
    ///     Exception detailed info to advise.
    /// </summary>
    public Dictionary<string, dynamic> Details { get; }
}
