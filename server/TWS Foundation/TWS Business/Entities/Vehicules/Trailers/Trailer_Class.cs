using System.ComponentModel.DataAnnotations.Schema;

using CSM_Database_Core.Core.Attributes;

using BNamedEntity = TWS_Business.Bases.BNamedEntity;

namespace TWS_Business.Entities.Vehicules.Trailers;

/// <summary>
///     [Entity] that stores information about <see cref="Trailer"/> classes.
/// </summary>
[Table("Trailer_Classes")]
public class Trailer_Class
    : BNamedEntity {

    #region Dependants

    /// <summary>
    ///     <see cref="Trailer_Type"/> dependants from this <see cref="Trailer_Class"/>.
    /// </summary>
    [EntityDependency("TrailerTypes", typeof(Trailer_Type), isCollection:true)]
    public virtual ICollection<Trailer_Type> TrailerTypes { get; set; } = [];

    #endregion
}
