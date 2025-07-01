using CSM_Foundation.Server.Scheming;

namespace TWS_Foundation.Middlewares.Frames;

public class SuccessFrame<TSuccess>
    : IResponseSchema<TSuccess> {

    public required Guid Id { get; init; }
    public required TSuccess Content { get; init; }
}
