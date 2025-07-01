using CSM_Foundation.Core.Bases;

namespace CSM_Foundation.Server.Exceptions;

/// <summary>
///     {exception} class from <see cref="BException{XDispositionSituation}"/>.
///     
///     <para>
///         Defines an exception object thrown at {Disposition} data process. 
///     </para>
/// </summary>
public class XDisposition
    : BException<XDispositionSituations> {

    /// <summary>
    ///     Creates a new <see cref="XDisposition"/> instance.
    /// </summary>
    /// <param name="situation"></param>
    /// <exception cref="ArgumentException"></exception>
    public XDisposition(XDispositionSituations situation)
        : base($"Data disposition process exception", situation) {
    }

    protected override Dictionary<XDispositionSituations, string> ResolveAdvise() {

        return new Dictionary<XDispositionSituations, string> {
            { XDispositionSituations.WrongToken, "Wrong {CSMDisposition} header value format" }
        };
    }
}

/// <summary>
///     <see langword="enum"/> implementation.
///     
///     <para>
///         Defines the available possible {Situations} for <see cref="XDisposition"/> exception invokation.
///     </para>
/// </summary>
public enum XDispositionSituations {
    /// <summary>
    ///     
    /// </summary>
    WrongToken,
}
