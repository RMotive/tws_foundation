using CSM_Foundation.Database.Quality;

namespace CSM_Security.Quality;
public class Q_Database
    : BQ_MigrationDatabases<Database> {
    public Q_Database() : base(new()) { }
}
