using System.Net;

using CSM_Foundation.Core.Bases;

namespace TWS_Customer.Features;


/// <summary>
///     {enum} implementation to represent the possible events that can throw <see cref="XRead"/> exception.
/// </summary>
public enum XReadReasons {
    /// <summary>
    ///     Thrown when a reading related method can't find a strict requested entity.
    /// </summary>
    UNFOUND
}

/// <summary>
///     
/// </summary>
public class XRead<TResource>
    : BException<XReadReasons> {

    /// <summary>
    ///     Creates a new <see cref="XRead"/> instance.
    /// </summary>
    /// <param name="reason">
    ///     Exception throw reason.
    /// </param>
    public XRead(XReadReasons reason)
        : base("Reading Event Exception", reason, HttpStatusCode.NotFound) {
    }

    protected override Dictionary<XReadReasons, string> ResolveAdvise() {
        return new Dictionary<XReadReasons, string> {
            { XReadReasons.UNFOUND, $"Requested resource ({typeof(TResource).Name}) not found" },
        };
    }
}
