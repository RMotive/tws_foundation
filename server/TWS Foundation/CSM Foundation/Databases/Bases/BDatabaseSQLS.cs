using System.Runtime.CompilerServices;

using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Utils;

using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Databases.Bases;
public abstract class BDatabaseSQLS<TSource>
    : DbContext, IMigrationSource
    where TSource : DbContext {

    private readonly SourceLinkOptions Connection;

    public BDatabaseSQLS([CallerFilePath] string? callerPath = null)
        : base() {
        Connection = MigrationUtils.Retrieve(callerPath);
    }
    public BDatabaseSQLS(DbContextOptions<TSource> Options, [CallerFilePath] string? callerPath = null)
        : base(Options) {
        Connection = MigrationUtils.Retrieve(callerPath);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    protected abstract ISourceSet[] EvaluateFactory();
    /// <summary>
    /// 
    /// </summary>
    public void Evaluate() {
        ISourceSet[] sets = EvaluateFactory();

        foreach (ISourceSet set in sets) {
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
    public void ValidateHealth(bool Announce = true) {
        AdvisorManager.Announce($"ORM Setting up *^____^*", new() {
            {"Database", GetType().Name },
            {"Base", nameof(BDatabaseSQLS<TSource>) }
        });

        if (Database.CanConnect()) {
            AdvisorManager.Success($"[{GetType().Name}] Connection stable");
        } else throw new Exception($"Connection unstable with datasource ({GetType().Name})");
    }
}
