using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Core.Extensions;
using CSM_Foundation.Database.Interfaces;

using Microsoft.EntityFrameworkCore;

namespace TWS_Foundation.Managers;

public class DispositionManager : IMigrationDisposer {
    private readonly IServiceProvider Servicer;
    private readonly Dictionary<DbContext, List<IDatabasesSet>> DispositionStack = [];
    private bool Active = false;

    public DispositionManager(IServiceProvider Servicer) {
        this.Servicer = Servicer;
    }

    public void Push(DbContext Databases, IDatabasesSet Record) {
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
        List<IDatabasesSet> recordsListed = [Record];
        DispositionStack.Add(Databases, recordsListed);
    }
    public void Push(DbContext Databases, IDatabasesSet[] Records) {
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
        List<IDatabasesSet> recordsListed = [.. Records.ToList()];
        DispositionStack.Add(Databases, recordsListed);
    }

    public void Status(bool Active) {
        this.Active = Active;
    }

    public void Dispose() {
        if (DispositionStack.Empty()) {
            AdvisorManager.Announce($"No records to dispose");
        }
        foreach (KeyValuePair<DbContext, List<IDatabasesSet>> disposeLine in DispositionStack) {
            using IServiceScope servicerScope = Servicer.CreateScope();
            DbContext Databases = disposeLine.Key;
            try {
                _ = Databases.Database.CanConnect();
            } catch (ObjectDisposedException) {
                Databases = (DbContext)servicerScope.ServiceProvider.GetRequiredService(Databases.GetType());
            }

            AdvisorManager.Announce($"Disposing db ({Databases.GetType()})");
            if (disposeLine.Value is null || disposeLine.Value.Count == 0) {
                AdvisorManager.Announce($"No records to dispose");
                continue;
            }
            int corrects = 0;
            int incorrects = 0;
            foreach (IDatabasesSet record in disposeLine.Value) {
                try {
                    _ = Databases.Remove(record);
                    _ = Databases.SaveChanges();
                    corrects++;
                    AdvisorManager.Success($"Disposed: ({record.GetType()}) | ({record.Id})");
                } catch (Exception Exep) {
                    incorrects++;
                    AdvisorManager.Warning($"No disposed: ({record.GetType()}) | ({record.Id}) |> ({Exep.Message})");
                }
            }

            if (incorrects > 0) {
                AdvisorManager.Warning($"Disposed with errors: (Errors: ({incorrects}) Successes: {corrects})");
            } else {
                AdvisorManager.Success($"Disposed: ({corrects} elements) at ({Databases.GetType()})");
            }
        }
    }
}
