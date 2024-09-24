using System.Net;
using System.Text.Json;

using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Server.Quality.Managers;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using Xunit;

namespace CSM_Foundation.Server.Quality.Bases;
/// <summary>
///     Defines base behaviors for quality operations to 
///     <see cref="BQ_Controller"/> implementations.
///     
///     <br></br>
///     <br> A Controller is the Server exposition for endpoints and another services. </br>
/// </summary>
/// <typeparam name="TEntry">
///     Entry class that starts your Server project.
/// </typeparam>
public abstract class BQ_ServerController<TEntry>
    : IClassFixture<WebApplicationFactory<TEntry>>
    where TEntry : class {
    private readonly JsonSerializerOptions SOptions = new();
    private readonly string Service;
    private readonly QM_ServerHost Host;
    
    protected BQ_ServerController(string Service, WebApplicationFactory<TEntry> Factory) {
        this.Service = Service;
        Host = new(Factory.CreateClient());
        SOptions.Converters.Add(new ISetViewFilterConverterFactory());
        SOptions.Converters.Add(new ISetViewFilterNodeConverterFactory());
    }


    #region Protected Abstract Methods

    protected abstract Task<string> Authentication();

    #endregion

    #region Protected Methods 

    protected TFrame Framing<TFrame>(GenericFrame Generic) {
        string desContent = JsonSerializer.Serialize(Generic);

        TFrame frame = JsonSerializer.Deserialize<TFrame>(desContent)!;
        return frame;
    }
    protected async Task<(HttpStatusCode, GenericFrame)> Post<TRequest>(string Action, TRequest Request, bool Authenticate = false) {
        return await Post<GenericFrame, TRequest>(Action, Request, false, Authenticate);
    }

    protected async Task<(HttpStatusCode, TResponse)> Post<TResponse, TRequest>(string Action, TRequest Request, bool Authenticate = false) {
        return await Post<TResponse, TRequest>(Action, Request, false, Authenticate);
    }

    protected async Task<(HttpStatusCode, TResponse)> XPost<TResponse, TRequest>(string Free, TRequest Request, bool Authenticate = false) {
        return await Post<TResponse, TRequest>(Free, Request, true, Authenticate);
    }

    #endregion

    protected string Serialize<T>(T value) {
        return JsonSerializer.Serialize(value, SOptions);
    }

    protected T Deserialize<T>(string json) {
        return JsonSerializer.Deserialize<T>(json, SOptions)
            ?? throw new Exception("Unable to deserealize object");
    }

    #region Private Methods 

    private async Task<(HttpStatusCode, TResponse)> Post<TResponse, TRequest>(string Action, TRequest RequestBody, bool FreeAction, bool Authenticate = false, string Disposition = "Quality") {
        if (Authenticate) {
            string authToken = await Authentication();
            Host.Authenticate(authToken);
        }
        if (!FreeAction) {
            Action = $"{Service}/{Action}";
        }

        Host.Disposition(Disposition);
        return await Host.Post<TResponse, TRequest>(Action, RequestBody, Options: SOptions);
    }
    #endregion
}
