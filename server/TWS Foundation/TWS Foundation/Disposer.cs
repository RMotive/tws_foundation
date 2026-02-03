using System.Collections.Concurrent;

using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation.Core.Extensions;
using CSM_Foundation.Logging;

using CSM_Foundation_Core.Abstractions.Interfaces;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace TWS_Foundation;

/// <summary>
///     [CSM Implementation] for a basic disposition data manager, handles data to be disposed after the server gets shut down. 
/// </summary>
public class Disposer
    : IDisposer<IEntity> {

    /// <summary>
    ///     Wheter the manager must keep track data or not.
    /// </summary>
    bool Active = false;

    /// <summary>
    ///     Service Provider to get database factories for instances location and handle data disposition on their corresponding contexts.
    /// </summary>
    readonly IServiceProvider _serviceProvider;

    /// <summary>
    ///     Manager main disposition context, handles the current managed databases context types and group them to handle easier a batch
    ///     entities disposition based on their context type.
    /// </summary>
    readonly ConcurrentDictionary<Type, List<IEntity>> _dispositionStack = new();

    /// <summary>
    ///     Creates a new <see cref="Disposer"/> instance.
    /// </summary>
    /// <param name="serviceProvider">
    ///     Service Provider locator, used to locate the database contexts factories.
    /// </param>
    public Disposer(IServiceProvider serviceProvider) {
        _serviceProvider = serviceProvider;
    }

    public void Push(IEntity entity) {
        if (!Active) {
            return;
        }

        _dispositionStack.AddOrUpdate(
                entity.Database.GetType(),
                [entity],
                (Type _, List<IEntity> previousList) => {
                    lock (previousList) {
                        previousList.Add(entity);
                    }

                    return previousList;
                }
            );
    }

    public void Push(IEntity[] entities) {
        if (!Active) {
            return;
        }

        IEnumerable<IGrouping<Type, IEntity>> groupedEntities = entities.GroupBy(
                entity => entity.Database.GetType()
            );

        foreach (IGrouping<Type, IEntity> databaseEntitiesGroup in groupedEntities) {

            _dispositionStack.AddOrUpdate(
                    databaseEntitiesGroup.Key,
                    [.. databaseEntitiesGroup],
                    (Type _, List<IEntity> previousList) => {
                        lock (previousList) {
                            previousList.AddRange(databaseEntitiesGroup);
                        }

                        return previousList;
                    }
                );
        }
    }

    /// <summary>
    ///     Changes the manager state.
    /// </summary>
    /// <param name="active">
    ///     Wheter the manager must be tracking data or not.
    /// </param>
    public void ChangeState(bool active) {
        Active = active;
    }

    public void Dispose() {
        if (_dispositionStack.Empty()) {
            Logger.Announce($"No records to dispose");
        }
        foreach (KeyValuePair<Type, List<IEntity>> disposeLine in _dispositionStack) {

            using IServiceScope servicerScope = _serviceProvider.CreateScope();

            DbContext Database = (DbContext)servicerScope.ServiceProvider.GetRequiredService(disposeLine.Key);

            Logger.Announce($"Disposing db ({Database.GetType()})");
            if (disposeLine.Value is null || disposeLine.Value.Count == 0) {
                Logger.Announce($"No records to dispose");
                continue;
            }
            int corrects = 0;
            int incorrects = 0;
            foreach (IEntity record in disposeLine.Value) {
                try {
                    Database.Remove(record);
                    Database.SaveChanges();

                    corrects++;
                    Logger.Success($"Disposed: ({record.GetType()}) | ({record.Id})");
                } catch (DbUpdateConcurrencyException ex) {
                    foreach (EntityEntry entry in ex.Entries) {
                        if (entry.Entity.GetType() == record.GetType()) {
                            entry.State = EntityState.Detached;
                        }
                    }

                } catch (Exception ex) {
                    incorrects++;
                    Logger.Warning($"No disposed: ({record.GetType()}) | ({record.Id}) |> ({ex.Message})");
                }
            }


            if (incorrects > 0) {
                Logger.Warning($"Disposed with errors: (Errors: ({incorrects}) Successes: {corrects})");
            } else {
                Logger.Success($"Disposed: ({corrects} elements) at ({Database.GetType()})");
            }
        }
        _dispositionStack.Clear();
    }
}
