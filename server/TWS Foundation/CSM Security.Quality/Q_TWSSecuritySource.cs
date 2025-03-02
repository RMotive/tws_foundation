using CSM_Foundation.Database.Quality;

using CSM_Security;

namespace CSM_Security.Quality;
public class Q_TWSSecurityDatabases
    : BQ_MigrationDatabases<Database> {
    public Q_TWSSecurityDatabases() : base(new()) { }
}
