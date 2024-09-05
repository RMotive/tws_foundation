namespace CSM_Foundation.Database.Interfaces;
public interface IDatabasesSet {
    public int Id { get; set; }
    public DateTime Timestamp { get; set; }

    public void EvaluateRead();
    public void EvaluateWrite();
    public Exception[] EvaluateDefinition();
}