using CSM_Foundation.Server.Interfaces;
using CSM_Foundation.Server.Records;

namespace TWS_Foundation.Middlewares.Frames;

public class FailureFrame
    : IServerFrame<ExceptionExposition> {
    public required Guid Tracer { get; init; }
    public required ExceptionExposition Estela { get; init; }
}
