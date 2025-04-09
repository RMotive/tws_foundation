using System.ComponentModel.DataAnnotations.Schema;

using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Vehicules.Trailers;

/// <summary>
///     [Entity] that stores information about <see cref="Trailer"/> classes.
/// </summary>
[Table("Trailer_Classes")]
public class Trailer_Class
    : BEntity, INamedEntity {

    #region Properties

    public string Name { get; set; } = default!;
    public string? Description { get; set; }

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Trailer_Type"/> dependants from this <see cref="Trailer_Class"/>.
    /// </summary>
    public virtual ICollection<Trailer_Type> TrailerTypes { get; set; } = [];

    #endregion
}
