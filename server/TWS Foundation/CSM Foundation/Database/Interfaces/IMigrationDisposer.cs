using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Database.Interfaces;
/// <summary>
/// 
/// </summary>
public interface IMigrationDisposer {
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Databases"></param>
    /// <param name="Set"></param>
    void Push(DbContext Databases, ISet Set);
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Databases"></param>
    /// <param name="Sets"></param>
    void Push(DbContext Databases, ISet[] Sets);
    /// <summary>
    /// 
    /// </summary>
    void Dispose();
}
