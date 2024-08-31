namespace CSM_Foundation.Databases.Interfaces;
public interface IDatabasesSet {
    public int Id { get; set; }

    public void EvaluateRead();
    public void EvaluateWrite();
    public Exception[] EvaluateDefinition();
}