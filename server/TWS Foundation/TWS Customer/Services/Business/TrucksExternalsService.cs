

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class TrucksExternalsService : ITrucksExternalsService {
    private readonly TrucksExternalsDepot TrucksExternals;

    public TrucksExternalsService(TrucksExternalsDepot trucksExternals) {
        TrucksExternals = trucksExternals;
    }

    private IQueryable<TruckExternal> Include(IQueryable<TruckExternal> query) {
        return query
            .Include(t => t.TruckCommonNavigation)
                .ThenInclude(t => t!.SituationNavigation)

            .Include(t => t.TruckCommonNavigation)
                .ThenInclude(t => t!.LocationNavigation)
                    .ThenInclude(t => t!.AddressNavigation)

            .Select(t => new TruckExternal() {
                Id = t.Id,
                Status = t.Status,
                Common = t.Common,
                UsaPlate = t.UsaPlate,
                MxPlate = t.MxPlate,
                Carrier = t.Carrier,
                Vin = t.Vin,
                TruckCommonNavigation = t.TruckCommonNavigation == null ? null : new TruckCommon() {
                    Id = t.TruckCommonNavigation.Id,
                    Status = t.TruckCommonNavigation.Status,
                    Economic = t.TruckCommonNavigation.Economic,
                    Location = t.TruckCommonNavigation.Location,
                    Situation = t.TruckCommonNavigation.Situation,
                    SituationNavigation = t.TruckCommonNavigation.SituationNavigation == null ? null : new Situation() {
                        Id = t.TruckCommonNavigation.SituationNavigation.Id,
                        Name = t.TruckCommonNavigation.SituationNavigation.Name,
                        Description = t.TruckCommonNavigation.SituationNavigation.Description
                    },
                    LocationNavigation = t.TruckCommonNavigation.LocationNavigation == null ? null : new Location() {
                        Id = t.TruckCommonNavigation.LocationNavigation.Id,
                        Status = t.TruckCommonNavigation.LocationNavigation.Status,
                        Name = t.TruckCommonNavigation.LocationNavigation.Name,
                        Address = t.TruckCommonNavigation.LocationNavigation.Address,
                        AddressNavigation = t.TruckCommonNavigation.LocationNavigation.AddressNavigation == null ? null : new Address() {
                            Id = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Id,
                            State = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.State,
                            Street = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Street,
                            AltStreet = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.AltStreet,
                            City = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.City,
                            Zip = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Zip,
                            Country = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Country,
                            Colonia = t.TruckCommonNavigation.LocationNavigation.AddressNavigation.Colonia
                        }
                    },
                },
            });
    }

    public async Task<SetViewOut<TruckExternal>> View(SetViewOptions<TruckExternal> Options) {
        return await TrucksExternals.View(Options, Include);
    }

    public async Task<SetBatchOut<TruckExternal>> Create(TruckExternal[] trucks) {
        return await TrucksExternals.Create(trucks);
    }

    public async Task<RecordUpdateOut<TruckExternal>> Update(TruckExternal Truck) {
        return await TrucksExternals.Update(Truck, Include);
    }
}
