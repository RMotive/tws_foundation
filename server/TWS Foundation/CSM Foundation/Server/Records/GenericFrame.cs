using CSM_Foundation.Server.Interfaces;

namespace CSM_Foundation.Server.Records;
public record GenericFrame
    : IServerFrame<Dictionary<string, object>> {
    public required Dictionary<string, object> Estela { get; init; }
    public required Guid Tracer { get; init; }
}
