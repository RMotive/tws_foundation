using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities.Trailers;

namespace TWS_Customer.Services.Interfaces;
public interface ITrailersService {
    Task<SetViewOut<Trailer>> View(SetViewOptions<Trailer> Options);
}
