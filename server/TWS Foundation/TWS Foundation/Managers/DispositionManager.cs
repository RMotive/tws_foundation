using System.Collections.Concurrent;

using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Core.Extensions;
using CSM_Foundation.Database.Interfaces;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace TWS_Foundation.Managers;

public class DispositionManager
    : IDisposer {

    private readonly IServiceProvider Servicer;
    private readonly ConcurrentDictionary<DbContext, List<ISet>> DispositionStack = [];
    private bool Active = false;

    public DispositionManager(IServiceProvider Servicer) {
        this.Servicer = Servicer;
    }

    public void Push(DbContext Databases, ISet Record) {
        if (!Active) {
            return;
        }

        Type DatabasesType = Databases.GetType();

        foreach (DbContext db in DispositionStack.Keys) {
            if (db.GetType() != DatabasesType) {
                continue;
            }

            DispositionStack[db].Add(Record);
            return;
        }
        List<ISet> recordsListed = [Record];
        DispositionStack.TryAdd(Databases, recordsListed);
    }
    public void Push(DbContext Databases, ISet[] Records) {
        if (!Active) {
            return;
        }

        Type DatabasesType = Databases.GetType();

        foreach (DbContext db in DispositionStack.Keys) {
            if (db.GetType() != DatabasesType) {
                continue;
            }

            DispositionStack[db].AddRange(Records);
            return;
        }
        List<ISet> recordsListed = [.. Records.ToList()];
        DispositionStack.TryAdd(Databases, recordsListed);
    }

    public void Status(bool Active) {
        this.Active = Active;
    }

    public void Dispose() {
        if (DispositionStack.Empty()) {
            AdvisorManager.Announce($"No records to dispose");
        }
        foreach (KeyValuePair<DbContext, List<ISet>> disposeLine in DispositionStack) {
            using IServiceScope servicerScope = Servicer.CreateScope();
            DbContext Database = disposeLine.Key;
            try {
                Database.Database.CanConnect();
            } catch (ObjectDisposedException) {
                Database = (DbContext)servicerScope.ServiceProvider.GetRequiredService(Database.GetType());
            }

            AdvisorManager.Announce($"Disposing db ({Database.GetType()})");
            if (disposeLine.Value is null || disposeLine.Value.Count == 0) {
                AdvisorManager.Announce($"No records to dispose");
                continue;
            }
            int corrects = 0;
            int incorrects = 0;
            foreach (ISet record in disposeLine.Value) {
                try {
                    Database.Remove(record);
                    Database.SaveChanges();
                    
                    corrects++;
                    AdvisorManager.Success($"Disposed: ({record.GetType()}) | ({record.Id})");
                } catch (DbUpdateConcurrencyException ex) {
                    foreach (EntityEntry entry in ex.Entries) {
                        if (entry.Entity.GetType() == record.GetType()) {
                            // Detach the failed entity to prevent retrying
                            entry.State = EntityState.Detached;
                        }
                    }

                } catch (Exception ex) {
                    incorrects++;
                    AdvisorManager.Warning($"No disposed: ({record.GetType()}) | ({record.Id}) |> ({ex.Message})");
                }
            }

            if (incorrects > 0) {
                AdvisorManager.Warning($"Disposed with errors: (Errors: ({incorrects}) Successes: {corrects})");
            } else {
                AdvisorManager.Success($"Disposed: ({corrects} elements) at ({Database.GetType()})");
            }
        }
    }
}
