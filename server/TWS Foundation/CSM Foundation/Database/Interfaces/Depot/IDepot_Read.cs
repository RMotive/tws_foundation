using System.Linq.Expressions;

using CSM_Foundation.Database.Enumerators;
using CSM_Foundation.Database.Models.Out;

namespace CSM_Foundation.Database.Interfaces.Depot;
public interface IDepot_Read<TMigrationSet>
    where TMigrationSet : ISet {

    public Task<SetComplexOut<TMigrationSet>> Read(Expression<Func<TMigrationSet, bool>> Predicate, SetReadBehaviors Behavior, Func<IQueryable<TMigrationSet>, IQueryable<TMigrationSet>>? Incluide = null);
}
