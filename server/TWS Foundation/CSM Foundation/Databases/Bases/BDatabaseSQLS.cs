using System.Runtime.CompilerServices;

using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Utils;

using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Databases.Bases;
public abstract class BDatabaseSQLS<TDatabases>
    : DbContext, IMigrationDatabases
    where TDatabases : DbContext {

    private readonly DatabasesLinkOptions Connection;

    public BDatabaseSQLS([CallerFilePath] string? callerPath = null)
        : base() {
        Connection = MigrationUtils.Retrieve(callerPath);
    }
    public BDatabaseSQLS(DbContextOptions<TDatabases> Options, [CallerFilePath] string? callerPath = null)
        : base(Options) {
        Connection = MigrationUtils.Retrieve(callerPath);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    protected abstract IDatabasesSet[] EvaluateFactory();
    /// <summary>
    /// 
    /// </summary>
    public void Evaluate() {
        IDatabasesSet[] sets = EvaluateFactory();

        foreach (IDatabasesSet set in sets) {
            _ = set.EvaluateDefinition();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="optionsBuilder"></param>
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) {
        optionsBuilder.UseSqlServer(Connection.GenerateConnectionString());
    }

    /// <summary>
    ///     Validates database connection health.
    /// </summary>
    public void ValidateHealth() {
        AdvisorManager.Announce($"ORM Setting up *^____^*", new() {
            {"Database", GetType().Name },
            {"Base", nameof(BDatabaseSQLS<TDatabases>) }
        });

        if (Database.CanConnect()) {
            AdvisorManager.Success($"[{GetType().Name}] Connection stable");
        } else throw new Exception($"Connection unstable with dataDatabases ({GetType().Name})");
    }
}
