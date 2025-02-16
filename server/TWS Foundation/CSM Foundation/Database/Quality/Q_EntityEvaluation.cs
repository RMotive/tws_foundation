using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

namespace CSM_Foundation.Database.Quality;
public record Q_EntityEvaluation<TEntity>
    where TEntity : IEntity {

    public (string, (IValidator, int)[])[] Expectations { get; init; } = [];
    public TEntity Mock { get; init; } = default!;

    public string Name { get; set; }

    public Q_EntityEvaluation(string Name) {
        this.Name = Name;
    }

    public Q_EntityEvaluation(string Name, TEntity Mock, (string, (IValidator, int)[])[] Expectations) {
        this.Name = Name;
        this.Mock = Mock;
        this.Expectations = Expectations;
    }
}
