using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TrailerClass"/> dataDatabases entity mirror.
/// </summary>
public class TrailerClassesDepot : BDepot<TWSBusinessDatabase, TrailerClass> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TrailerClass"/>.
    /// </summary>
    public TrailerClassesDepot() : base(new(), null) {
    }
}
