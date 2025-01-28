

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using Xunit;

namespace TWS_Customer.Services;
public class TrailersExternalsService : ITrailersExternalsService {
    private readonly TrailersExternalsDepot TrailersExternals;
    private readonly TWSBusinessDatabase Database;
    protected readonly IDisposer? Disposer;
    public TrailersExternalsService(TrailersExternalsDepot TrailersExternals, TWSBusinessDatabase Database, IDisposer? Disposer) {
        this.TrailersExternals = TrailersExternals;
        this.Database = Database;
        this.Disposer = Disposer;
    }

    private IQueryable<TrailerExternal> Include(IQueryable<TrailerExternal> query) {
        return query
            .Select(p => new TrailerExternal() {
                Id = p.Id,
                Timestamp = p.Timestamp,
                Status = p.Status,
                Common = p.Common,
                UsaPlate = p.UsaPlate,
                MxPlate = p.MxPlate,
                Carrier = p.Carrier,
                TrailerCommonNavigation = p.TrailerCommonNavigation == null ? null : new TrailerCommon() {
                    Id = p.TrailerCommonNavigation.Id,
                    Timestamp = p.TrailerCommonNavigation.Timestamp,
                    Status = p.TrailerCommonNavigation.Status,
                    Economic = p.TrailerCommonNavigation.Economic,
                    Type = p.TrailerCommonNavigation.Type,
                    Situation = p.TrailerCommonNavigation.Situation,
                    Location = p.TrailerCommonNavigation.Location,
                    SituationNavigation = p.TrailerCommonNavigation.SituationNavigation == null ? null : new Situation() {
                        Id = p.TrailerCommonNavigation.SituationNavigation.Id,
                        Timestamp = p.TrailerCommonNavigation.SituationNavigation.Timestamp,
                        Name = p.TrailerCommonNavigation.SituationNavigation.Name,
                        Description = p.TrailerCommonNavigation.SituationNavigation.Description,
                    },
                    TrailerTypeNavigation = p.TrailerCommonNavigation.TrailerTypeNavigation == null ? null : new TrailerType() {
                        Id = p.TrailerCommonNavigation.TrailerTypeNavigation.Id,
                        Timestamp = p.TrailerCommonNavigation.TrailerTypeNavigation.Timestamp,
                        Status = p.TrailerCommonNavigation.TrailerTypeNavigation.Status,
                        Size = p.TrailerCommonNavigation.TrailerTypeNavigation.Size,
                        TrailerClass = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClass,
                        TrailerClassNavigation = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation == null ? null : new TrailerClass() {
                            Id = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Id,
                            Timestamp = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Timestamp,
                            Name = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Name,
                            Description = p.TrailerCommonNavigation.TrailerTypeNavigation.TrailerClassNavigation.Description,
                        }
                    },
                    LocationNavigation = p.TrailerCommonNavigation.LocationNavigation == null ? null : new Location() {
                        Id = p.TrailerCommonNavigation.LocationNavigation.Id,
                        Timestamp = p.TrailerCommonNavigation.LocationNavigation.Timestamp,
                        Status = p.TrailerCommonNavigation.LocationNavigation.Status,
                        Name = p.TrailerCommonNavigation.LocationNavigation.Name,
                        Address = p.TrailerCommonNavigation.LocationNavigation.Address,
                        AddressNavigation = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation == null ? null : new Address() {
                            Id = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Id,
                            Timestamp = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Timestamp,
                            State = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.State,
                            Street = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Street,
                            AltStreet = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.AltStreet,
                            City = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.City,
                            Zip = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Zip,
                            Country = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Country,
                            Colonia = p.TrailerCommonNavigation.LocationNavigation.AddressNavigation.Colonia,
                        },
                    },
                },
            });

    }

    public async Task<SetViewOut<TrailerExternal>> View(SetViewOptions<TrailerExternal> Options) {
        return await TrailersExternals.View(Options, Include);
    }
    public async Task<SetBatchOut<TrailerExternal>> Create(TrailerExternal[] Trailers) {
        return await TrailersExternals.Create(Trailers);
    }
    // Custom update method implementation for external trailers records.
    public async Task<RecordUpdateOut<TrailerExternal>> Update(TrailerExternal Trailer) {
        // Evaluate record.
        Trailer.EvaluateWrite();
       
        // Check if the trailer currently exist in database.
        // current: fetch and stores the lastest record data in database to compare and update with the trailer parameter.
        TrailerExternal? current = await Include(Database.TrailersExternals)
            .Where(i => i.Id == Trailer.Id)
            .FirstOrDefaultAsync();

        // If trailer not exist in database, then use the generic update method.
        if (current == null) {
            return await TrailersExternals.Update(Trailer, Include);
        }
        // Save a deep copy before changes.
        TrailerExternal previousDeepCopy = current.DeepCopy();
        // Clear the navigation to avoid duplicated tracking issue.
        current.TrailerCommonNavigation = null;
        current.StatusNavigation = null;

        // Update the main model properties.

        Database.Attach(current);
        EntityEntry previousEntry = Database.Entry(current);
        previousEntry.CurrentValues.SetValues(Trailer);

        // --->Update TrailerCommon navigation
        if (Trailer.TrailerCommonNavigation != null) {
            current.Common = Trailer.TrailerCommonNavigation.Id;
            current.TrailerCommonNavigation = Trailer.TrailerCommonNavigation;
        }

        // --->Update Situation navigation
        if (Trailer.TrailerCommonNavigation?.SituationNavigation != null) {
            current.TrailerCommonNavigation!.Situation = Trailer.TrailerCommonNavigation!.SituationNavigation!.Id;
            current.TrailerCommonNavigation!.SituationNavigation = Trailer.TrailerCommonNavigation!.SituationNavigation;
        }

        // ---> Update TrailerType navigation
        if (Trailer.TrailerCommonNavigation?.TrailerTypeNavigation != null) {
            current.TrailerCommonNavigation!.Type = Trailer.TrailerCommonNavigation!.TrailerTypeNavigation!.Id;
            current.TrailerCommonNavigation!.TrailerTypeNavigation = Trailer.TrailerCommonNavigation!.TrailerTypeNavigation;
        }
        await Database.SaveChangesAsync();
        Disposer?.Push(Database, Trailer);
        // Get the lastest record data from database.
        TrailerExternal? lastestRecord = await Include(Database.TrailersExternals)
            .Where(i => i.Id == Trailer.Id)
            .FirstOrDefaultAsync();

        return new RecordUpdateOut<TrailerExternal> {
            Previous = previousDeepCopy,
            Updated = lastestRecord ?? Trailer,
        };
    }
}
