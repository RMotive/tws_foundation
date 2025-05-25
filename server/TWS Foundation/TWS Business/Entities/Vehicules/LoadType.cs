using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [etBuilder] that stores information about a specific type of load for <see cref="Trailer"/> loading information.
/// </summary>
public class LoadType
    : BEntity, INamedEntity {

    #region Properties

    public string Name { get; set; } = default!;
    public string? Description { get; set; }

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="YardLog"/> dependants from this <see cref="LoadType"/>.
    /// </summary>
    public ICollection<YardLog> YardLogs { get; set; } = [];

    #endregion
}
