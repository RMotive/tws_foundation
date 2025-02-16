using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Database.Entity;
/// <summary>
/// 
/// </summary>
public interface IDisposer {
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Databases"></param>
    /// <param name="Set"></param>
    void Push(DbContext Databases, IEntity Set);
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Databases"></param>
    /// <param name="Sets"></param>
    void Push(DbContext Databases, IEntity[] Sets);
    /// <summary>
    /// 
    /// </summary>
    Task Dispose();
}
