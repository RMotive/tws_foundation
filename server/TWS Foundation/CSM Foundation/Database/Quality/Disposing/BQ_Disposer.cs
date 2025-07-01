using System.Collections.Concurrent;

using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace CSM_Foundation.Database.Quality.Disposing;

/// <summary>
///     Public Delegate for [database] factory [Quality] purposes.
/// </summary>
/// <returns>
///     The database context instance.
/// </returns>
public delegate DbContext DatabaseFactory();

/// <summary>
///     [Abstract] base class to handle [Quality] purposes [Disposer]s implementations.
/// </summary>
public abstract class BQ_Disposer
    : IQ_Disposer {

    /// <summary>
    ///     Current [Disposer] Database factories available.  
    /// </summary>
    protected Dictionary<Type, DatabaseFactory> Factories { get; private init; } = [];

    /// <summary>
    ///     Current [Disposer] queue entities to dispose related with their databases owners.
    /// </summary>
    protected ConcurrentDictionary<Type, IEntity[]> Queue { get; private init; } = [];

    /// <summary>
    ///     Creates a new <see cref="BQ_Disposer"/> instance, an abtract class handling [Quality] pusposes [Disposing] data behaviors.
    /// </summary>
    /// <param name="Factories"></param>
    public BQ_Disposer(params DatabaseFactory[] Factories) {
        foreach (DatabaseFactory Factory in Factories) {
            using DbContext instance = Factory();

            Type dbType = instance.GetType();
            this.Factories.Add(dbType, Factory);
            Queue.AddOrUpdate(
                    dbType,
                    (_) => [],
                    (_, prev) => [.. prev]
                );
        }
    }

    public void Push(IEntity Record) {
        if (Factories.ContainsKey(Record.Database)) {
            Queue.AddOrUpdate(
                    Record.Database,
                    (_) => [Record],
                    (_, prev) => [.. prev, Record]
                );

        } else {
            throw new Exception($"Tried to push a record for Disposition with no subscribed database owning factory ({Record.Database.Name}).");
        }
    }

    public void Push(IEntity[] Records) {
        foreach (IEntity Record in Records) {
            Push(Record);
        }
    }

    public void Dispose() {
        foreach (KeyValuePair<Type, IEntity[]> Database in Queue) {
            Type dbType = Database.Key;
            DatabaseFactory factory = Factories[dbType];

            using DbContext database = factory();
            IEnumerable<IEntity> committedEntities = Database.Value.Where(i => i.Id > 0).Reverse();

            foreach (IEntity committedEntity in committedEntities) {
                EntityEntry entry = database.Entry(committedEntity);
                if(entry.GetDatabaseValues() is null) {
                    continue;
                }

                // Delete ICollection Entities before deleting the main entity.
                foreach (var property in committedEntity.GetType().GetProperties()) {
                    if (typeof(IEnumerable<IEntity>).IsAssignableFrom(property.PropertyType)) {
                        if (property.GetValue(committedEntity) is IEnumerable<IEntity> collection) {
                            foreach (var item in collection) {
                                EntityEntry subEntry = database.Entry(item);
                                if (subEntry.GetDatabaseValues() is null) {
                                    continue;
                                }

                                subEntry.State = EntityState.Deleted;
                            }
                        }
                    }
                }


                entry.DetectChanges();
                entry.State = EntityState.Deleted;
                database.SaveChanges();
            }
        }
    }
}
