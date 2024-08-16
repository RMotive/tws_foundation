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
        AdvisorManager.Announce($"ORM Setting things up...", new() {
            {"Database", GetType().Name },
            {"Base", nameof(BDatabaseSQLS<TSource>) },
        });
        Connection = MigrationUtils.Retrieve(callerPath);
        ValidateHealth();
    }
    public BDatabaseSQLS(DbContextOptions<TSource> Options, [CallerFilePath] string? callerPath = null)
        : base(Options) {
        AdvisorManager.Announce($"ORM Setting things up...", new() {
            {"Database", GetType().Name },
            {"Base", nameof(BDatabaseSQLS<TSource>) },
        });
        Connection = MigrationUtils.Retrieve(callerPath);
        ValidateHealth();
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
    /// 
    /// </summary>
    private void ValidateHealth() {
        AdvisorManager.Announce($"[{GetType().Name}] Running connection checker...");

        if (Database.CanConnect()) {
            AdvisorManager.Success($"[{GetType().Name}] connection successfuly stablished");
        }
    }
}
