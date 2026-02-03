
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation.Server.Exceptions;

using CSM_Foundation_Core.Abstractions.Interfaces;

using Microsoft.Extensions.Primitives;

namespace TWS_Foundation.Middlewares;

public class DispositionMiddleware : IMiddleware {
    private const string DISP_HEAD_KEY = "CSMDisposition";
    private const string DISP_HEAD_VALUE = "Quality";
    private readonly Disposer Disposer;

    public DispositionMiddleware(IDisposer<IEntity> Disposer) {
        this.Disposer = (Disposer)Disposer;
    }

    public async Task InvokeAsync(HttpContext context, RequestDelegate next) {
        HttpRequest request = context.Request;

        StringValues headers = request.Headers[DISP_HEAD_KEY];

        bool Activate = false;
        if (headers.Count > 0) {
            if (!headers.Contains(DISP_HEAD_VALUE)) {
                throw new XDisposition(XDispositionSituations.WrongToken);
            }

            Activate = true;
        }

        Disposer.ChangeState(Activate);
        await next(context);
    }
}