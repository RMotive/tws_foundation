using TWS_Customer.Managers;

namespace TWS_Customer.Quality.Suits.Managers;


public class Q_ConfigurationManager {
    private readonly ConfigurationManager Manager = ConfigurationManager.Manager;

    [Fact]
    public void Q_GetSolution() {
        Manager.GetSolution("TWSMG");
    }
}
