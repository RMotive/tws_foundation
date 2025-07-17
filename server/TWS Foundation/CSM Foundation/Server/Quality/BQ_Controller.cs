using System.Net;
using System.Text.Json;

using CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;
using CSM_Foundation.Server.Scheming;

using Microsoft.AspNetCore.Mvc.Testing;

using Xunit;

namespace CSM_Foundation.Server.Quality;


/// <summary>
///     Represents a base testing suit for server controller, providing base behavior to handle network requests and quality of responses.
/// </summary>
/// <typeparam name="TProgram">
///     Type of the application entry class.
/// </typeparam>
public abstract class BQ_Controller<TProgram>
    : IClassFixture<WebApplicationFactory<TProgram>>
    where TProgram : class {

    /// <summary>
    ///     Internal JSON serializer options.
    /// </summary>
    readonly JsonSerializerOptions _serializerOptions = new();

    /// <summary>
    ///     Server communication client internal manager object.
    /// </summary>
    readonly QM_ServerHost _serverHost;

    /// <summary>
    ///     Service path to be qualified.
    /// </summary>
    protected readonly string controllerPath;

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="controllerPath">
    ///     Controller's path.
    /// </param>
    /// <param name="solutionSign">
    ///     Internal { CSM } management solution sign identifier, used to identify { Solution } information, metadata, security params, etc.
    /// </param>
    /// <param name="applicationFactory">
    ///     Fixture proxy application factory dependency.
    /// </param>
    protected BQ_Controller(string controllerPath, string solutionSign, WebApplicationFactory<TProgram> applicationFactory) {
        this.controllerPath = controllerPath;

        _serverHost = new(solutionSign, applicationFactory.CreateClient());

        _serializerOptions.Converters.Add(new ISetViewFilterConverterFactory());
        _serializerOptions.Converters.Add(new ISetViewFilterNodeConverterFactory());

        ConfigureSerializer(_serializerOptions);
    }


    /// <summary>
    ///     Configures the internal <see cref="JsonSerializerOptions"/> instance for quality/testing purposes.
    /// </summary>
    /// <param name="jsonSerializerOptions">
    ///     Internal serializer options instance to override needed options.
    /// </param>
    protected virtual void ConfigureSerializer(JsonSerializerOptions jsonSerializerOptions) { }

    /// <summary>
    ///     Authenticates a quality/testing purposes request with the server.
    /// </summary>
    /// <returns>
    ///     Auth token.
    /// </returns>
    protected abstract Task<string> Authenticate();

    /// <summary>
    ///     Serializes the given <paramref name="object"/> based on the internal configured <see cref="JsonSerializerOptions"/>.
    /// </summary>
    /// <typeparam name="T2">
    ///     Type of the <paramref name="object"/> object to serialize.
    /// </typeparam>
    /// <param name="object">
    ///     Object instance to serialize.
    /// </param>
    /// <returns>
    ///     Serialization of given <paramref name="object"/>.
    /// </returns>
    protected string Serialize<T2>(T2 @object) {
        return JsonSerializer.Serialize(@object, _serializerOptions);
    }

    /// <summary>
    ///     Deserealizes the given <paramref name="serial"/> based on the internal configured <see cref="JsonSerializerOptions"/>.
    /// </summary>
    /// <typeparam name="T2">
    ///     Type of the object the given <paramref name="serial"/> should be converted to.
    /// </typeparam>
    /// <param name="serial">
    ///     Serialization value to deserealize.
    /// </param>
    /// <returns>
    ///     Deserealized object from the given <paramref name="serial"/>.
    /// </returns>
    protected T2 Deserialize<T2>(string serial) {
        return JsonSerializer.Deserialize<T2>(serial, _serializerOptions)
            ?? throw new Exception("Unable to deserealize object");
    }

    #region Protected Methods 

    protected TFrame Framing<TFrame>(ResponseSchema Generic) {
        string desContent = JsonSerializer.Serialize(Generic);

        TFrame frame = JsonSerializer.Deserialize<TFrame>(desContent)!;
        return frame;
    }

    protected async Task<(HttpStatusCode, ResponseSchema)> Post<TRequest>(string Action, TRequest Request, bool Authenticate = false) {
        return await Post<ResponseSchema, TRequest>(Action, Request, false, Authenticate);
    }

    protected async Task<(HttpStatusCode, TResponse)> Post<TResponse, TRequest>(string Action, TRequest Request, bool Authenticate = false) {
        return await Post<TResponse, TRequest>(Action, Request, false, Authenticate);
    }

    protected async Task<(HttpStatusCode, TResponse)> XPost<TResponse, TRequest>(string Free, TRequest Request, bool Authenticate = false) {
        return await Post<TResponse, TRequest>(Free, Request, true, Authenticate);
    }

    #endregion


    private async Task<(HttpStatusCode, TResponse)> Post<TResponse, TRequest>(string endpoint, TRequest body, bool unrelative = false, bool useAuth = false, string disposition = "Quality") {
        if (useAuth) {
            string authToken = await Authenticate();
            _serverHost.Authenticate(authToken);
        }
        if (!unrelative) {
            endpoint = $"{controllerPath}/{endpoint}";
        }

        _serverHost.Disposition(disposition);
        return await _serverHost.Post<TResponse, TRequest>(endpoint, body, Options: _serializerOptions);
    }
}
