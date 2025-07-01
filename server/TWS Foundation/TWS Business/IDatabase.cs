using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Employees;

namespace TWS_Business;

/// <summary>
///     [Interface] for [TWS Business] database implementations.
/// </summary>
public interface IDatabase {

    /// <summary>
    ///     [Employee] [Entity] database Entity.
    /// </summary>
    DbSet<Employee> Employees { get; set; }
}
