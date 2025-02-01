using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Security.Depots;
using TWS_Security.Sets;

namespace TWS_Customer.Services;
public class PermitsService
    : IPermitsService {
    
    private readonly PermitsDepot PermitsDepot;
   
    public PermitsService(PermitsDepot Permits) {
        PermitsDepot = Permits;
    }
    private IQueryable<Permit> Include(IQueryable<Permit> query) {
        return query
            .Select(p => new Permit {
                Id = p.Id,
                Timestamp = p.Timestamp,
                Solution = p.Solution,
                Feature = p.Feature,
                Action = p.Action,
                Reference = p.Reference,
                Enabled = p.Enabled,
                SolutionNavigation = p.SolutionNavigation != null? new Solution() {
                    Id = p.SolutionNavigation.Id,
                    Timestamp = p.SolutionNavigation.Timestamp,
                    Name = p.SolutionNavigation.Name,
                    Sign = p.SolutionNavigation.Sign,
                    Description = p.SolutionNavigation.Description,
                } : null,
                FeatureNavigation = p.FeatureNavigation != null? new Feature() { 
                    Id= p.FeatureNavigation.Id,
                    Timestamp = p.FeatureNavigation.Timestamp,
                    Name = p.FeatureNavigation.Name,
                    Description = p.FeatureNavigation.Description,
                    Enabled = p.FeatureNavigation.Enabled,
                }: null,
                
            });
    }

    public async Task<SetViewOut<Permit>> View(SetViewOptions<Permit> Options) {
        return await PermitsDepot.View(Options, Include);
    }
    
}
