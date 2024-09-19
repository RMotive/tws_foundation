

using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services;
public class TrucksExternalsService : ITrucksExternalsService {
    private readonly TrucksExternalsDepot TrucksExternals;

    public TrucksExternalsService(TrucksExternalsDepot trucksExternals) {
        TrucksExternals = trucksExternals;
    }

    public async Task<SetViewOut<TruckExternal>> View(SetViewOptions Options) {
        static IQueryable<TruckExternal> include(IQueryable<TruckExternal> query) {
            return query
            .Include(t => t.TruckCommonNavigation)
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
                    Economic = t.TruckCommonNavigation.Economic,
                    Location = t.TruckCommonNavigation.Location,
                    Situation = t.TruckCommonNavigation.Situation,
                },
            });

        }
        return await TrucksExternals.View(Options, include);
    }

    public async Task<DatabasesTransactionOut<TruckExternal>> Create(TruckExternal[] trucks) {
        return await this.TrucksExternals.Create(trucks);
    }

    public async Task<RecordUpdateOut<TruckExternal>> Update(TruckExternal Truck) {
        static IQueryable<TruckExternal> include(IQueryable<TruckExternal> query) {
            return query
            .Include(t => t.TruckCommonNavigation)

            .Include(t => t.TruckCommonNavigation)
                .ThenInclude(t => t!.LocationNavigation)

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
                    LocationNavigation = t.TruckCommonNavigation.LocationNavigation == null? null : new Location() {
                        Id= t.TruckCommonNavigation.LocationNavigation.Id,
                        Status = t.TruckCommonNavigation.LocationNavigation.Status,
                        Name = t.TruckCommonNavigation.LocationNavigation.Name,
                        Address = t.TruckCommonNavigation.LocationNavigation.Address,
                        AddressNavigation = t.TruckCommonNavigation.LocationNavigation.AddressNavigation == null? null : new Address() {
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

        return await TrucksExternals.Update(Truck, include);
    }
}
