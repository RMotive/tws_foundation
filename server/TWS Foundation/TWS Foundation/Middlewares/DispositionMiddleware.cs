
using CSM_Foundation.Server.Exceptions;

using Microsoft.Extensions.Primitives;
using CSM_Foundation.Database.Entity;

namespace TWS_Foundation.Middlewares;

public class DispositionMiddleware : IMiddleware {
    private const string DISP_HEAD_KEY = "CSMDisposition";
    private const string DISP_HEAD_VALUE = "Quality";
    private readonly SampleDisposer Disposer;

    public DispositionMiddleware(IDisposer Disposer) {
        this.Disposer = (SampleDisposer)Disposer;
    }

    public async Task InvokeAsync(HttpContext context, RequestDelegate next) {
        HttpRequest request = context.Request;

        StringValues headers = request.Headers[DISP_HEAD_KEY];

        bool Activate = false;
        if (headers.Count > 0) {
            if (!headers.Contains(DISP_HEAD_VALUE)) {
                throw new XDisposition(XDispositionSituation.Value);
            }

            Activate = true;
        }

        Disposer.Status(Activate);
        await next(context);
    }
}