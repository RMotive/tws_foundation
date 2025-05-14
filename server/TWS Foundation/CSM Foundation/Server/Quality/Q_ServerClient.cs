using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text.Json;

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Testing;

namespace CSM_Foundation.Server.Quality;


/// <summary>
///     {model} <see langword="record"/> implementation.
///     
///     <para>
///         Defines a data model to handle responses from <see cref="Q_ServerClient"/> operations, that simplifies how http calls are made to the
///         server simulator for testing purposes.
///     </para>
/// </summary>
/// <typeparam name="T">
///     Data model for the response content.
/// </typeparam>
public record Q_ServerClient_Response<T> {

    /// <summary>
    ///     Native HTTP response status code from WWW standards.
    /// </summary>
    public required HttpStatusCode StatusCode { get; init; }

    /// <summary>
    ///     Reponse content data.
    /// </summary>
    public required T Content { get; init; } = default!;
}

/// <summary>
///     <see langword="class"/> implementations.
/// 
///     <para> 
///         Defines a final implementation that manages a quality/testing purposes server mirror simulation for simplified server requests tests(integration)
///     </para>
/// </summary>
public class Q_ServerClient
    : IDisposable {

    /// <summary>
    ///    Internal reference for custom {CSM} authentication headers format.
    /// </summary>
    private const string AUTH_TOKEN = "CSMAuth";

    /// <summary>
    ///     Internal reference for custom {CSM} disposition headers format.
    /// </summary>
    private const string DISPOSITION_TOKEN = "CSMDisposition";

    /// <summary>
    ///    Native http command client lower level handling object.
    /// </summary>
    readonly HttpClient _httpClient;

    /// <summary>
    ///     Current server context identification sign.
    /// </summary>
    /// <remarks>
    ///     Format: strict 5 chars.
    /// </remarks>
    readonly string _serverSign;

    /// <summary>
    ///    Creates a new <see cref="Q_ServerClient"/> instance.
    /// </summary>
    /// <param name="serverSign">
    ///     Mirror server sign identifier, used to identify {Solution} information, metadata, security params, etc.
    /// </param>
    /// <param name="webApplicationClient">
    ///     Web Application context scope client object.
    /// </param>
    /// <param name="useDisposition">
    ///     Whether the client requests must enable server disposition.
    /// </param>
    /// <exception cref="ArgumentException">
    ///     Thrown when the <paramref name="serverSign"/> is not strictly 5 characters long.
    /// </exception>
    public Q_ServerClient(string serverSign, HttpClient webApplicationClient, bool useDisposition = true) {
        if(serverSign.Length != 5) {
            throw new ArgumentException("Server sign must be 5 characters long", nameof(serverSign));
        }

        _serverSign = serverSign;
        _httpClient = webApplicationClient;

        if(useDisposition) {
            _httpClient.DefaultRequestHeaders.Add(DISPOSITION_TOKEN, "");
        }
    }

    /// <summary>
    ///     Posts a call to the server simulator context.
    /// </summary>
    /// <typeparam name="T">
    ///     Type of the data model used as the response content.
    /// </typeparam>
    /// <typeparam name="T2">
    ///     Type of the data model used as the request content.
    /// </typeparam>
    /// <param name="endpoint">
    ///     HTTP Standard endpoint to be requested.
    /// </param>
    /// <param name="requestContent">
    ///     Data content for the request.
    /// </param>
    /// <param name="authToken">
    ///     Whether the request needs {CSM} authentication.
    /// </param>
    /// <param name="scopedJsonSerializerOptions">
    ///     Custom request scoped serializer options.
    /// </param>
    /// <returns>
    ///     The correct parsed response data model.
    /// </returns>
    /// <exception cref="Exception">
    ///     Thrown when the response content cannot be converted to the expected type (<typeparamref name="T"/>).
    /// </exception>
    public async Task<Q_ServerClient_Response<T>> Post<T, T2>(string endpoint, T2 requestContent, string? authToken,  JsonSerializerOptions? scopedJsonSerializerOptions = null) {
        if(authToken != null) {
            SetAuth(authToken);
        }
        
        HttpResponseMessage httpResponse = await _httpClient.PostAsJsonAsync(endpoint, requestContent, options: scopedJsonSerializerOptions);
        
        HttpStatusCode resolutionCode = httpResponse.StatusCode;

        T responseContent = await httpResponse.Content.ReadFromJsonAsync<T>()
            ?? throw new Exception($"Unable to convert response content to {typeof(T)}");

        RestoreClient();

        return new Q_ServerClient_Response<T> {
            StatusCode = resolutionCode,
            Content = responseContent
        };
    }

    void IDisposable.Dispose() {
        _httpClient.Dispose();
        GC.SuppressFinalize(this);
    }

    /// <summary>
    ///     Restores the internal built-in <see cref="_httpClient"/> object to its default state.
    /// </summary>
    private void RestoreClient() {
        _httpClient.DefaultRequestHeaders.Clear();
    }

    /// <summary>
    ///     Configures the given <paramref name="token"/> as the {CSM} authentication format for the current server context requests.
    /// </summary>
    /// <param name="token">
    ///     Specific request authentication token.
    /// </param>
    /// <remarks>
    ///     CSM Authentication Format: CSMAuth {token}@{_serverSign}
    /// </remarks>
    private void SetAuth(string token) {
        _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(AUTH_TOKEN, $"{token}@{_serverSign}");
    }
}
