using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities;

namespace TWS_Customer.Services.Interfaces;
public interface ISituationsService {

    Task<SetViewOut<Situation>> View(SetViewOptions<Situation> options);
    Task<Situation> Create(Situation situation);

}
