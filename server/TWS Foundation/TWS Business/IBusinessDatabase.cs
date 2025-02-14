using Microsoft.EntityFrameworkCore;

using TWS_Business.Entities.Employees;

namespace TWS_Business;

/// <summary>
///     [Interface] for [TWS Business] database implementations.
/// </summary>
public interface IBusinessDatabase {

    /// <summary>
    ///     [Employee] [Entity] database Set.
    /// </summary>
    DbSet<Employee> Employees { get; set; }
}
