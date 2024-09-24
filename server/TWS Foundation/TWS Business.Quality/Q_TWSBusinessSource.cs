using CSM_Foundation.Database.Quality.Bases;

namespace TWS_Business.Quality;

public class Q_TWSBusinessDatabases
    : BQ_MigrationDatabases<TWSBusinessDatabase> {
    public Q_TWSBusinessDatabases() : base(new()) { }
}