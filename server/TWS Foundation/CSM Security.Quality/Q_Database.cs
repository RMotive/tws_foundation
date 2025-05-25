using CSM_Foundation.Database.Quality;

namespace CSM_Security.Quality;

public class Q_Database 
    : BQ_Database<Database> {

    public Q_Database() 
        : base(Database.SIGN) {
    }
}
