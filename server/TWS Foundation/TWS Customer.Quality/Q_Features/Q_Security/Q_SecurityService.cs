using CSM_Foundation.Customer.Quality;
using CSM_Foundation.Database.Quality.Disposing;

using TWS_Customer.Features.Security;

namespace TWS_Customer.Quality.Q_Features.Q_Security;

/// <summary>
///     
/// </summary>
public class Q_SecurityService 
    : BQ_Service<ISecurityService> {

    readonly Q_Disposer _disposer;

    public Q_SecurityService()
        : base() { 
        
    }

    [Fact(DisplayName = "[Authenticate]: ")]
    public void Authenticate() {


    }
}
