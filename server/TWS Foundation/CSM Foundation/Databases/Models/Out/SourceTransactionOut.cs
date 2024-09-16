using CSM_Foundation.Databases.Interfaces;

namespace CSM_Foundation.Databases.Models.Out;
public record DatabasesTransactionOut<TSet>
    where TSet : IDatabasesSet {
    public TSet[] Successes { get; init; }
    public SourceTransactionFailure<TSet>[] Failures { get; init; }
    public int QTransactions { get; private set; }
    public int QSuccesses { get; private set; }
    public int QFailures { get; private set; }
    public bool Failed { get; private set; }

    public DatabasesTransactionOut(TSet[] Successes, SourceTransactionFailure<TSet>[] Failures) {
        this.Successes = Successes;
        this.Failures = Failures;
        QSuccesses = this.Successes.Length;
        QFailures = this.Failures.Length;
        QTransactions = QSuccesses + QFailures;
        Failed = QFailures > 0;
    }
}