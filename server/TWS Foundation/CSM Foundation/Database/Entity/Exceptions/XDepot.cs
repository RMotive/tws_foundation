using System.Net;

using CSM_Foundation.Core.Bases;

namespace CSM_Foundation.Database.Entity.Exceptions;

/// <summary>
///     [Exception] to notify critical errors found during [<see cref="IDepot{TEntity}"/>] operations.
/// </summary>
public class XDepot
    : BException<XDepotSituations> {

    protected Type Type;

    protected string Filter;

    public XDepot(Type entityType, string Filter, XDepotSituations Situation, Exception? System = null)
        : base($"[{entityType.Name}] Record Error", Situation, HttpStatusCode.InternalServerError, System) {

        Type = entityType;
        this.Filter = Filter;

        Factors = new Dictionary<string, dynamic> {
            { nameof(entityType), entityType },
            { nameof(Filter), Filter },
        };
    }

    protected override Dictionary<XDepotSituations, string> AdviseFactory() {
        return new Dictionary<XDepotSituations, string> {
            { XDepotSituations.Unfound, $"Unable to find required record from set ${Type.Name}" },
        };
    }
}


/// <summary>
///     [Exception] [Situations] for <see cref="XDepot"/>
/// </summary>
public enum XDepotSituations {
    /// <summary>
    ///     Used when a searched <see cref="IEntity"/> wasn't found.
    /// </summary>
    Unfound,
}