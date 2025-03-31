using CSM_Foundation.Database.Utilitites;

namespace TWS_Customer.Quality.Factories;


public static class DatabaseFactories {

    public static CSM_Security.Database SecurityDatabaseFactory()
    => DatabaseUtilities.Q_Construct<CSM_Security.Database>(CSM_Security.Database.SIGN);

    public static TWS_Business.Database BusinessDatabaseFactory()
    => DatabaseUtilities.Q_Construct<TWS_Business.Database>(TWS_Business.Database.SIGN);
}
