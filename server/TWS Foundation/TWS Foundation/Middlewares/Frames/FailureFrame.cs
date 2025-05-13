using CSM_Foundation.Server;
using CSM_Foundation.Server.Scheming;

namespace TWS_Foundation.Middlewares.Frames;

public class FailureFrame
    : IResponseSchema<ExceptionInfo> {
    public required Guid Id { get; init; }
    public required ExceptionInfo Content { get; init; }
}
