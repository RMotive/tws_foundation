

using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Trailers;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class TrailersService : ITrailersService {
    private readonly TrailersDepot Trailers;

    public TrailersService(TrailersDepot trailers) {
        Trailers = trailers;
    }

    public async Task<SetViewOut<Trailer>> View(SetViewOptions<Trailer> Options) {
        static IQueryable<Trailer> include(IQueryable<Trailer> query) {
            return query
            .Include(t => t.Common)

            .Include(t => t.Carrier)
                .ThenInclude(c => c!.Address)
            .Include(t => t.Carrier)
                .ThenInclude(c => c!.Approach)
            .Include(t => t.Carrier)
                .ThenInclude(c => c!.USDOT)

            .Include(t => t.Model);
        }
        return await Trailers.View(Options, include);
    }
}
