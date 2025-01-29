using System.Diagnostics;
using System.Net;

using CSM_Foundation.Core.Constants;
using CSM_Foundation.Core.Interfaces;
using CSM_Foundation.Server.Records;

namespace CSM_Foundation.Core.Bases;

/// <summary>
///     Base class that determines a custom CSM Exception for internal engines purposes.
/// </summary>
/// <typeparam name="TSituation">
///     Specific exception situation codes determined by enumerator.
/// </typeparam>
public abstract class BException<TSituation>
    : Exception, IException<TSituation>
    where TSituation : Enum {


    public string Trace { get; init; }
    public string Subject { get; protected set; } = string.Empty;
    public string Advise { get; protected set; } = string.Empty;
    public Exception? System { get; init; } = null;
    public TSituation Situation { get; protected set; } = default!;
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
    public BException(string Subject, TSituation Situation, HttpStatusCode Status = HttpStatusCode.InternalServerError, Exception? System = null)
        : base(System?.Message ?? Subject) {

        // --> If this exception wasn't created based on another caught exception the StackTrace is the object creation point.
        Trace = System?.StackTrace ?? new StackTrace().ToString();

        this.Subject = Subject;
        this.System = System;
        this.Situation = Situation;
        this.Status = Status;

        Advise = DetermineAdvise();
    }

    /// <summary>
    ///     Builds a configuration for the exception implementation, this configuration will determine what <see cref="Advise"/> to load based on the
    ///     given <see cref="Situation"/> at the object construction time. 
    ///     
    ///     <para>
    ///         This is a <see langword="virtual"/> method 'cause it's optional, but it needs to be a factory method due to sometimes might Advises message contain
    ///         variable references and needs access to the stored properties.
    ///     </para>
    /// </summary>
    /// <returns></returns>
    protected virtual Dictionary<TSituation, string> AdviseFactory() {
        return [];
    }

    /// <summary>
    ///     Evaluates each advise configuration from <see cref="AdviseFactory"/> to determine based on the <see cref="Situation"/> the advise to load.
    /// </summary>
    /// <returns>
    ///     The exception user friendly advise.
    /// </returns>
    private string DetermineAdvise() {
        Dictionary<TSituation, string> advises = AdviseFactory();

        string advise = AdvisesConstants.SERVER_CONTACT_ADVISE;
        foreach (KeyValuePair<TSituation, string> possibleAdvise in advises) {
            if (Situation.Equals(possibleAdvise.Key)) {
                advise = possibleAdvise.Value;
                break;
            }
        }

        return advise;
    }

    public ExceptionExposition Publish() {
        return new ExceptionExposition() {
            Advise = Advise,
            Situation = Convert.ToInt32(Situation),
            System = (System?.GetType().ToString() ?? "N/A") + $"|{Message}",
            Trace = Trace[..200],
        };
    }
}
