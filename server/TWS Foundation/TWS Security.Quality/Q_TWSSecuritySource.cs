﻿using CSM_Foundation.Database.Quality.Bases;

namespace TWS_Security.Quality;
public class Q_TWSSecurityDatabases
    : BQ_MigrationDatabases<TWSSecurityDatabase> {
    public Q_TWSSecurityDatabases() : base(new()) { }
}
