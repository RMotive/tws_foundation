using CSM_Foundation.Server.Interfaces;
using CSM_Foundation.Server.Records;

namespace TWS_Foundation.Middlewares.Frames;

public class FailureFrame
    : IServerFrame<ServerExceptionPublish> {
    public required Guid Tracer { get; init; }
    public required ServerExceptionPublish Estela { get; init; }
}
