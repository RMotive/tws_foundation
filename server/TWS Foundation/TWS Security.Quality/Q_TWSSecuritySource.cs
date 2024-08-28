using CSM_Foundation.Databases.Quality.Bases;

namespace TWS_Security.Quality;
public class Q_TWSSecurityDatabases
    : BQ_MigrationDatabases<TWSSecurityDatabases> {
    public Q_TWSSecurityDatabases() : base(new()) { }
}
