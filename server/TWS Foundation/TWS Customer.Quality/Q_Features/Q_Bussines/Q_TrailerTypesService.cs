using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business.Vehicules;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_TrailerTypesService
    : BQ_Service<ITrailerTypesService, Trailer_Type> {

    protected override Trailer_Type DraftEntity(string entropy) {
        throw new NotImplementedException();
    }

    protected override ITrailerTypesService ServiceFactory() {
        throw new NotImplementedException();
    }
}
