using CSM_Foundation.Database.Entity;

namespace CSM_Foundation.Database.Bases;
public interface IIncludableQueryable<TEntity> where TEntity : class, IEntity {
}