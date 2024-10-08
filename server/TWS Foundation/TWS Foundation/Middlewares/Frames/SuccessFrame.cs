﻿using CSM_Foundation.Server.Interfaces;

namespace TWS_Foundation.Middlewares.Frames;

public class SuccessFrame<TSuccess>
    : IServerFrame<TSuccess> {

    public required Guid Tracer { get; init; }
    public required TSuccess Estela { get; init; }
}
