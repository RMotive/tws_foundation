namespace CSM_Foundation.Advisor.Interfaces;

/// <summary>
///     Interface to determine an advising exception used in Advising CSM engine.
/// </summary>
public interface IAdvisingException {

    /// <summary>
    ///     Subjecto of the exception (i.e. Advising Engine Exception).
    /// </summary>
    public string Subject { get; }

    /// <summary>
    ///     Descriptive error message.
    /// </summary>
    public string Message { get; }

    /// <summary>
    ///     System exception caught trace description.
    /// </summary>
    public string Trace { get; }

    /// <summary>
    ///     Exception detailed info to advise.
    /// </summary>
    public Dictionary<string, dynamic> Details { get; }
}
