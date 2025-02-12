using System.Net;

using CSM_Foundation.Core.Bases;

namespace CSM_Foundation.Database.Exceptions;

/// <summary>
///     [Exception] to notify critical errors found during [Set] records handling.
/// </summary>
public class XRecord
    : BException<XRecordSituations> {

    protected Type Type;

    protected string Filter;

    public XRecord(Type Type, string Filter, XRecordSituations Situation, Exception? System = null)
        : base($"[{Type.Name}] Record Error", Situation, HttpStatusCode.InternalServerError, System) {

        this.Type = Type;
        this.Filter = Filter;

        Factors = new Dictionary<string, dynamic> {
            { nameof(Type), Type },
            { nameof(Filter), Filter },
        };
    }

    protected override Dictionary<XRecordSituations, string> AdviseFactory() {
        return new Dictionary<XRecordSituations, string> {
            { XRecordSituations.Unfound, $"Unable to find required record from set ${Type.Name}" },
        };
    }
}


/// <summary>
///     [Exception] [Situations] for <see cref="XRecord"/>
/// </summary>
public enum XRecordSituations {
    /// <summary>
    ///     Used when a required record search fails.
    /// </summary>
    Unfound,
}