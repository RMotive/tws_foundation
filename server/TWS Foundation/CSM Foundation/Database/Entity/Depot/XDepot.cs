using System.Net;

using CSM_Foundation.Core.Bases;
using CSM_Foundation.Core.Constants;

namespace CSM_Foundation.Database.Entity.Depot;

/// <summary>
///     [Exception] to notify critical errors found during [<see cref="IDepot{TEntity}"/>] operations.
/// </summary>
public class XDepot<TEntity>
    : BException<XDepotSituations> 
    where TEntity : IEntity {

    protected Type EntityType;

    protected string? Filter;

    public XDepot(XDepotSituations Situation, string? Filter = "", Exception? System = null)
        : base($"[{typeof(TEntity).Name}] Record Error", Situation, HttpStatusCode.InternalServerError, System) {

        EntityType = typeof(TEntity);
        this.Filter = Filter;

        Factors = new Dictionary<string, dynamic> {
            { nameof(EntityType), EntityType},
            { nameof(Filter), Filter ?? "---" },
        };
    }

    protected override Dictionary<XDepotSituations, string> AdviseFactory() {
        return new Dictionary<XDepotSituations, string> {
            { XDepotSituations.Unfound, $"Unable to find required entity from set ${typeof(TEntity).Name}" },
            { XDepotSituations.CreateDisabled, $"{AdvisesConstants.SERVER_CONTACT_ADVISE}" }
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

    /// <summary>
    ///     Usedn when at an Update operation the <see cref="IEntity"/> given has <see cref="IEntity.Id"/> 0
    ///     (wich usually means a new entity creation) but <seealso cref="UpdateInput.Create"/> is set to false.
    /// </summary>
    CreateDisabled,
}