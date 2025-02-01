using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Customer.Services.Interfaces;

using TWS_Security.Depots;
using TWS_Security.Sets;

namespace TWS_Customer.Services;
public class ProfilesService
    : IProfileService {
    
    private readonly ProfilesDepot ProfilesDepot;
   
    public ProfilesService(ProfilesDepot Permits) {
        ProfilesDepot = Permits;
    }
    private IQueryable<Profile> Include(IQueryable<Profile> query) {
        return query
            .Select(p => new Profile {
                Id = p.Id,
                Timestamp = p.Timestamp,
                Name = p.Name,
                Description = p.Description,
            });
    }

    public async Task<SetViewOut<Profile>> View(SetViewOptions<Profile> Options) {
        return await ProfilesDepot.View(Options, Include);
    }
    
}
