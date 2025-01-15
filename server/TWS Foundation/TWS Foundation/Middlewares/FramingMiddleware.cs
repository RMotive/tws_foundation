using System.Net;
using System.Text.Json;

using CSM_Foundation.Core.Exceptions;
using CSM_Foundation.Core.Interfaces;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Http.Extensions;

using TWS_Foundation.Middlewares.Frames;

namespace TWS_Foundation.Middlewares;

public class FramingMiddleware
    : IMiddleware {
    public async Task InvokeAsync(HttpContext context, RequestDelegate next) {
        Guid Tracer;
        try {
            Tracer = Guid.Parse(context.TraceIdentifier);
        } catch {
            Tracer = Guid.NewGuid();
            context.TraceIdentifier = Tracer.ToString();
        }


        using MemoryStream bufferingStream = new();

        IException? failure = null;
        string ContentType = "application/json";

        try {
            context.Response.Body = bufferingStream;
            await next.Invoke(context);
        } catch (Exception ex) when (ex is IException Exception) {
            failure = Exception;
        } catch (Exception ex) {
            XSystem systemEx = new(ex);
            failure = systemEx;
        } finally {
            HttpResponse response = context.Response;
            Stream responseStream = response.Body;

            if (!response.HasStarted) {
                _ = bufferingStream.Seek(0, SeekOrigin.Begin);
                string encodedContent = "";
                if (failure is not null) {
                    ExceptionExposition exPublish = failure.Publish();

                    FailureFrame frame = new() {
                        Tracer = Tracer,
                        Estela = exPublish,
                    };

                    response.StatusCode = (int)failure.Status;
                    encodedContent = JsonSerializer.Serialize(frame);
                } else if (response.StatusCode != 200) {

                    switch (response.StatusCode) {
                        case 204:
                            encodedContent = "{}";
                            break;
                        case 405: {
                                ExceptionExposition publish = new XSystem(new MethodAccessException()).Publish();
                                FailureFrame frame = new() {
                                    Tracer = Tracer,
                                    Estela = publish,
                                };
                                encodedContent = JsonSerializer.Serialize(frame);
                            }
                            break;
                        case 404: {
                                ExceptionExposition publish = new XSystem(new Exception($"{context.Request.GetDisplayUrl()} not found")).Publish();
                                FailureFrame frame = new() {
                                    Tracer = Tracer,
                                    Estela = publish,
                                };

                                encodedContent = JsonSerializer.Serialize(frame);
                            }
                            break;
                        default:
                            Dictionary<string, object> jObject = JsonSerializer.Deserialize<Dictionary<string, object>>(responseStream)!;

                            SuccessFrame<Dictionary<string, dynamic>> defFrame = new() {
                                Tracer = Tracer,
                                Estela = jObject,
                            };
                            encodedContent = JsonSerializer.Serialize(defFrame);
                            break;
                    }
                } else {
                    Dictionary<string, dynamic> resolution = JsonSerializer.Deserialize<Dictionary<string, dynamic>>(responseStream)!;

                    SuccessFrame<Dictionary<string, dynamic>> frame = new() {
                        Tracer = Tracer,
                        Estela = resolution,
                    };

                    response.StatusCode = (int)HttpStatusCode.OK;
                    encodedContent = JsonSerializer.Serialize(frame);
                }

                response.ContentType = ContentType;


                MemoryStream swapperBuffer = new();
                StreamWriter writer = new(swapperBuffer);

                await writer.WriteAsync(encodedContent);
                await writer.FlushAsync();

                swapperBuffer.Seek(0, SeekOrigin.Begin);
                response.Body = swapperBuffer;
            }
        }
    }
}