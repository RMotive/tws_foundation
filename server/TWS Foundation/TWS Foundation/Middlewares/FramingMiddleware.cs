using System.Net;
using System.Text.Json;

using CSM_Foundation.Core;
using CSM_Foundation.Core.Interfaces;
using CSM_Foundation.Server;

using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.EntityFrameworkCore.Storage;

using TWS_Foundation.Middlewares.Frames;

namespace TWS_Foundation.Middlewares;

/// <summary>
/// 
/// </summary>
public class FramingMiddleware
    : IMiddleware {

    /// <summary>
    /// 
    /// </summary>
    const string DEF_CONTENT_TYPE = "application/json";


    public async Task InvokeAsync(HttpContext context, RequestDelegate next) {
        if (!Guid.TryParse(context.TraceIdentifier, out Guid Tracer)) {
            Tracer = Guid.NewGuid();
            context.TraceIdentifier = Tracer.ToString();
        }

        // --> Starting [EF] services transactions.
        CSM_Security.Database securityDatabase = context.RequestServices.GetRequiredService<CSM_Security.Database>();
        using IDbContextTransaction securityDatabaseTransaction = await securityDatabase.Database.BeginTransactionAsync();

        IException? failure = null;

        using MemoryStream reqProxyBuffer = new();

        try {
            context.Response.Body = reqProxyBuffer;

            await next.Invoke(context);

            await securityDatabaseTransaction.CommitAsync();
        } catch (Exception ex) when (ex is IException Exception) {
            failure = Exception;

            await securityDatabaseTransaction.RollbackAsync();
        } catch (Exception ex) {
            XSystem systemEx = new("System engine exception", ex);
            failure = systemEx;

            await securityDatabaseTransaction.RollbackAsync();
        } finally {
            HttpResponse response = context.Response;
            Stream responseStream = response.Body;

            if (!response.HasStarted) {
                _ = reqProxyBuffer.Seek(0, SeekOrigin.Begin);
                string encodedContent = "";
                if (failure is not null) {
                    ExceptionInfo exPublish = failure.Expose();

                    FailureFrame frame = new() {
                        Id = Tracer,
                        Content = exPublish,
                    };

                    response.StatusCode = (int)failure.Status;
                    encodedContent = JsonSerializer.Serialize(frame);
                } else if (response.StatusCode != 200) {

                    switch (response.StatusCode) {
                        case 204:
                            encodedContent = "{}";
                            break;
                        case 405: {
                                ExceptionInfo publish = new XSystem("Unsuported HTTP method", null)
                                    .Expose();
                                FailureFrame frame = new() {
                                    Id = Tracer,
                                    Content = publish,
                                };
                                encodedContent = JsonSerializer.Serialize(frame);
                            }
                            break;
                        case 404: {
                                ExceptionInfo publish = new XSystem($"{context.Request.GetDisplayUrl()} not found", null)
                                    .Expose();
                                FailureFrame frame = new() {
                                    Id = Tracer,
                                    Content = publish,
                                };

                                encodedContent = JsonSerializer.Serialize(frame);
                            }
                            break;
                        default:
                            Dictionary<string, object> jObject = JsonSerializer.Deserialize<Dictionary<string, object>>(responseStream)!;

                            SuccessFrame<Dictionary<string, dynamic>> defFrame = new() {
                                Id = Tracer,
                                Content = jObject,
                            };
                            encodedContent = JsonSerializer.Serialize(defFrame);
                            break;
                    }
                } else {

                    Dictionary<string, dynamic> resolution = JsonSerializer.Deserialize<Dictionary<string, dynamic>>(responseStream)!;

                    SuccessFrame<Dictionary<string, dynamic>> frame = new() {
                        Id = Tracer,
                        Content = resolution,
                    };

                    response.StatusCode = (int)HttpStatusCode.OK;
                    encodedContent = JsonSerializer.Serialize(frame);
                }

                response.ContentType = DEF_CONTENT_TYPE;


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