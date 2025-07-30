using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_TrailersService
    : BQ_Service<ITrailersService, Trailer_Common> {

    protected override Trailer_Common DraftEntity(string entropy) {
        throw new NotImplementedException();
    }

    protected override ITrailersService ServiceFactory() {
        throw new NotImplementedException();
    }
}