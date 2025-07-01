using System.Diagnostics;
using System.Net;

using CSM_Foundation.Core.Constants;
using CSM_Foundation.Core.Interfaces;
using CSM_Foundation.Server;

namespace CSM_Foundation.Core.Bases;

/// <summary>
///     Base class that determines a custom CSM Exception for internal engines purposes.
/// </summary>
/// <typeparam name="TEvents">
///     Specific exception situation codes determined by enumerator.
/// </typeparam>
public abstract class BException<TEvents>
    : Exception, IException<TEvents>
    where TEvents : Enum {


    public string Trace { get; init; }
    public string Subject { get; protected set; } = string.Empty;
    public string Advise { get; private init; }
    public Exception? System { get; init; } = null;
    public TEvents Reason { get; private init; } = default!;
    public Dictionary<string, dynamic> Details { get; init; } = [];
    public Dictionary<string, dynamic> Factors { get; init; } = [];
    public HttpStatusCode Status { get; init; }

    /// <summary>
    ///     Creates a new abstract object for <see cref="BException{TSituation}"/>
    /// </summary>
    /// <param name="Subject">
    ///     Exception implementation subject.
    /// </param>
    /// <param name="Situation">
    ///     Exception thrown situation identification.
    /// </param>
    /// <param name="Status">
    ///     Public HTTP Request status code to serve.
    /// </param>
    /// <param name="System">
    ///     Internal system caught exception object
    /// </param>
    public BException(string Subject, TEvents Situation, HttpStatusCode Status = HttpStatusCode.InternalServerError, Exception? System = null)
        : base(System?.Message ?? Subject) {

        // --> If this exception wasn't created based on another caught exception the StackTrace is the object creation point.
        Trace = System?.StackTrace ?? new StackTrace().ToString();

        this.Subject = Subject;
        this.System = System;
        this.Reason = Situation;
        this.Status = Status;

        Advise = DetermineAdvise();
    }

    /// <summary>
    ///     Builds a configuration for the exception implementation, this configuration will determine what <see cref="Advise"/> to load based on the
    ///     given <see cref="Reason"/> at the object construction time. 
    ///     
    ///     <para>
    ///         This is a <see langword="virtual"/> method 'cause it's optional, but it needs to be a factory method due to sometimes might Advises message contain
    ///         variable references and needs access to the stored properties.
    ///     </para>
    /// </summary>
    /// <returns></returns>
    protected abstract Dictionary<TEvents, string> ResolveAdvise();

    /// <summary>
    ///     Evaluates each advise configuration from <see cref="ResolveAdvise"/> to determine based on the <see cref="Reason"/> the advise to load.
    /// </summary>
    /// <returns>
    ///     The exception user friendly advise.
    /// </returns>
    private string DetermineAdvise() {
        Dictionary<TEvents, string> advises = ResolveAdvise();

        string advise = AdvisesConstants.SERVER_CONTACT_ADVISE;
        foreach (KeyValuePair<TEvents, string> possibleAdvise in advises) {
            if (Reason.Equals(possibleAdvise.Key)) {
                advise = possibleAdvise.Value;
                break;
            }
        }

        return advise;
    }

    public ExceptionInfo Expose() {
        return new ExceptionInfo() {
            Advise = Advise,
            Situation = Convert.ToInt32(Reason),
            System = (System?.GetType().ToString() ?? "N/A") + $"|{Message}",
            Trace = Trace[..200],
        };
    }
}
