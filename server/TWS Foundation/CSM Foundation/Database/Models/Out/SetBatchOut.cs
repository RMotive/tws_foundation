 using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Models.Out;
public record SetBatchOut<TSet>
    where TSet : ISet {
    public TSet[] Successes { get; init; }
    public SetOperationFailure[] Failures { get; init; }
    public int QTransactions { get; private set; }
    public int QSuccesses { get; private set; }
    public int QFailures { get; private set; }
    public bool Failed { get; private set; }

    public SetBatchOut(TSet[] Successes, SetOperationFailure[] Failures) {
        this.Successes = Successes;
        this.Failures = Failures;
        QSuccesses = this.Successes.Length;
        QFailures = this.Failures.Length;
        QTransactions = QSuccesses + QFailures;
        Failed = QFailures > 0;
    }
}