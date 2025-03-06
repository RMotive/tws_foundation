using CSM_Foundation.Database.Quality;

namespace TWS_Business.Quality;

public class Q_TWSBusinessDatabases
    : BQ_MigrationDatabases<Database> {
    public Q_TWSBusinessDatabases() : base(new()) { }
}