using System.Net;

using CSM_Foundation.Logging;
using CSM_Foundation.Server;

namespace CSM_Foundation.Core.Interfaces;

/// <summary>
///     Defines the behavior for an exception thrown at Server level. This means
///     an exception thrown when a Server request was being tried to be resolved but there arised an exception.
/// </summary>
public interface IException<TReasons>
    : ILoggingException, IException
    where TReasons : Enum {

    /// <summary>
    ///     Enumeration of possible <see cref="Reason"/>s for this exception.
    ///     <br> This field is used to handle validations along different reason codes easily </br>
    /// </summary>
    public TReasons Reason { get; }
}

/// <summary>
///     Defines a {CSM} exception interface specifying required properties to correctly describe a {Server} managed
///     exception and how to expose it for client.
/// </summary>
public interface IException {
    
    /// <summary>
    ///     An user friendly message, usually used when the requester gets the transaction resolution.
    /// </summary>
    public string Advise { get; }
    
    /// <summary>
    ///     The internal system exception object caught.
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
    ///     Converts the current exception details into a public information details object. 
    /// </summary>
    /// <returns>
    ///     Public exception details.
    /// </returns>
    public ExceptionInfo Expose();
}