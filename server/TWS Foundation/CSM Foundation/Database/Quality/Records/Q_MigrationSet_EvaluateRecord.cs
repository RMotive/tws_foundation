using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Quality.Records;
public record Q_MigrationSet_EvaluateRecord<TSet>
    where TSet : ISet {

    public (string, (IValidator, int)[])[] Expectations { get; init; } = [];
    public TSet Mock { get; init; } = default!;

    public string Name { get; set; }

    public Q_MigrationSet_EvaluateRecord(string Name) {
        this.Name = Name;
    }

    public Q_MigrationSet_EvaluateRecord(string Name, TSet Mock, (string, (IValidator, int)[])[] Expectations) {
        this.Name = Name;
        this.Mock = Mock;
        this.Expectations = Expectations;
    }
}
