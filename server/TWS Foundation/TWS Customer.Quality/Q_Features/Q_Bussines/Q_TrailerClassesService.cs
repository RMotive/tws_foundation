using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business.Vehicules;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_TrailerClassesService
    : BQ_Service<ITrailerClassesService, Trailer_Class> {

    protected override Trailer_Class DraftEntity(string entropy) {
        throw new NotImplementedException();
    }
    protected override ITrailerClassesService ServiceFactory() {
        throw new NotImplementedException();
    }
}
