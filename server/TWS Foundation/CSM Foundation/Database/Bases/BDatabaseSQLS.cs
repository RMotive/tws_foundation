using System.Runtime.CompilerServices;

using CSM_Foundation.Advisor.Managers;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Utils;

using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Database.Bases;
public abstract class BDatabaseSQLS<TDatabases>
    : DbContext, IMigrationDatabases
    where TDatabases : DbContext {

    protected readonly DatabasesLinkOptions Connection;

    protected string Sign;

    public BDatabaseSQLS(string Sign)
        : base() {

        this.Sign = Sign.ToUpper();
        Connection = MigrationUtils.Retrieve(this.Sign);
    }
    public BDatabaseSQLS(string Sign, DbContextOptions<TDatabases> Options)
        : base(Options) {

        this.Sign = Sign;
        Connection = MigrationUtils.Retrieve(this.Sign);
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

        } else {
            try {
                Database.OpenConnection();
            } catch (Exception ex) {
                
                throw new Exception($"Invalid connection with Database ({GetType().Name}) | {ex.InnerException?.Message}");
            }
        }
    }
}
