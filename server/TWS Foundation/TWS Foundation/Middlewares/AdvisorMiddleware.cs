
using System.Text.Json;

using CSM_Foundation.Logging;

using JObject = System.Collections.Generic.Dictionary<string, object?>;

namespace TWS_Foundation.Middlewares;

public class AdvisorMiddleware
    : IMiddleware {
    public async Task InvokeAsync(HttpContext context, RequestDelegate next) {
        try {
            Logger.Announce(
                $"Received server request from ({context.Connection.RemoteIpAddress}:{context.Connection.RemotePort})",
                new() {
                    {"Tracer", context.TraceIdentifier }
                }
            );
            Stream OriginalStream = context.Response.Body;
            await next(context);
            HttpResponse Response = context.Response;
            if (!Response.HasStarted) {
                Stream bufferStream = Response.Body;
                JObject? responseContent = await JsonSerializer.DeserializeAsync<JObject>(bufferStream);
                if (responseContent != null && responseContent.TryGetValue("Details", out dynamic? value)) {
                    JsonElement Estela = value;
                    JObject? EstelaObject = Estela.Deserialize<JObject>();
                    if (EstelaObject != null && EstelaObject.ContainsKey("Failure")) {
                        Logger.Warning($"Reques served with failure", responseContent);
                    } else {
                        Logger.Success($"Request served successful", responseContent);
                    }
                } else if (Response.StatusCode != 204) {
                    Logger.Success($"Request served successful", responseContent);
                }

                if (Response.StatusCode != 204) {
                    _ = bufferStream.Seek(0, SeekOrigin.Begin);
                    await bufferStream.CopyToAsync(OriginalStream);
                    Response.Body = OriginalStream;
                }
            }
        } catch {
            throw;
        }
    }
}
