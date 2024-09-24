using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;


namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Sct"/> dataDatabases entity mirror.
/// </summary>
public class SctsDepot
: BDepot<TWSBusinessDatabase, Sct> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Sct"/>.
    /// </summary>

    public SctsDepot()
        : base(new(), null) {

    }

}
