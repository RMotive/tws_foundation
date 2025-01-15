using System.Net;

using CSM_Foundation.Advisor.Interfaces;
using CSM_Foundation.Server.Records;

namespace CSM_Foundation.Core.Interfaces;
/// <summary>
///     Defines the behavior for an exception
///     thrown on Server transaction time, this means
///     an exceptio thrown when a Server request was being tried to
///     be resolved but there arised an exception.
/// </summary>
public interface IException<TSituation>
    : IAdvisingException, IException
    where TSituation : Enum {
    /// <summary>
    ///     Enumeration of possible situations for this exception.
    ///     <br> This field is used to handle validations along different sitautions codes easily </br>
    /// </summary>
    public TSituation Situation { get; }
}

public interface IException {
    /// <summary>
    ///     An user friendly message, usually used when the requester gets the transaction resolution.
    /// </summary>
    public string Advise { get; }
    /// <summary>
    ///     The SystemInternal exception thrown that arised this Server known exception.
    /// </summary>
    public Exception? System { get; }
    /// <summary>
    ///     Indicates a custom status code for the transaction resolution.
    /// </summary>
    public HttpStatusCode Status { get; }
    /// <summary>
    ///     Stores custom factors to analyze the thrown exception.
    /// </summary>
    public Dictionary<string, dynamic> Factors { get; }

    /// <summary>
    ///     
    /// </summary>
    /// <returns></returns>
    public ExceptionExposition Publish();
}