using System.Collections.Concurrent;

using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Quality.Interfaces;

using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Database.Quality.Tools;

/// <summary>
/// 
/// </summary>
public class QDisposer
    : IQ_Disposer {

    /// <summary>
    /// 
    /// </summary>
    required public Func<DbContext> Factory { private get; init; }

    /// <summary>
    /// 
    /// </summary>
    private readonly ConcurrentQueue<IEntity> Teardown = new();

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Databases"></param>
    /// <param name="Set"></param>
    public void Push(IEntity Set) {
        Teardown.Enqueue(Set);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Databases"></param>
    /// <param name="Records"></param>
    /// <exception cref="NotImplementedException"></exception>
    public void Push(IEntity[] Records) {
        foreach (IEntity record in Records) {
            Teardown.Enqueue(record);
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <exception cref="NotImplementedException"></exception>
    public void Dispose() {
        DbContext database = Factory();

        database.RemoveRange(Teardown);
        database.SaveChanges();
    }
}
