using CSM_Foundation.Databases.Quality.Bases;

namespace TWS_Business.Quality;

public class Q_TWSBusinessDatabases
    : BQ_MigrationDatabases<TWSBusinessDatabases> {
    public Q_TWSBusinessDatabases() : base(new()) { }
}