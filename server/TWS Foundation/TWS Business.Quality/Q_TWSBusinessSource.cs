using CSM_Foundation.Databases.Quality.Bases;

namespace TWS_Business.Quality;

public class Q_TWSBusinessSource
    : BQ_MigrationSource<TWSBusinessSource> {
    public Q_TWSBusinessSource() : base(new()) { }
}