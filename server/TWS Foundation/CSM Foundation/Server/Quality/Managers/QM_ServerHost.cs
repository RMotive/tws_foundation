using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text.Json;

using Microsoft.AspNetCore.Http;

namespace CSM_Foundation.Server.Quality.Managers;


/// <summary>
///     <see langword="class"/> implementation for <see cref="QM_ServerHost"/>.
///     
/// 
///     <para> 
///         Defines a final implementation that manages a quality/testing purposes server mirror simulation for simplified server requests tests(integration)
///     </para>
/// </summary>
/// <param name="Sign"></param>
/// <param name="host"></param>
public class QM_ServerHost {
    private const string AUTH_TOKEN = "CSMAuth";

    private const string DISPOSITION_TOKEN = "CSMDisposition";

    readonly HttpClient _httpClient;

    readonly string _serverSign;

    public QM_ServerHost(string serverSign, HttpClient httpClient) {
        _serverSign = serverSign;
        _httpClient = httpClient;
    }

    public async Task<(HttpStatusCode, TResponse)> Post<TResponse, TRequest>(string Location, TRequest Request, JsonSerializerOptions? Options = null) {
        HttpResponseMessage Response = await _httpClient.PostAsJsonAsync(Location, Request, options: Options);
        HttpStatusCode resolutionCode = Response.StatusCode;

        TResponse resolution = await Response.Content.ReadFromJsonAsync<TResponse>()
            ?? throw new Exception("Nullified deserealization");

        Restore();
        return (resolutionCode, resolution);
    }

    public void Dispose() {
        _httpClient.Dispose();
    }
    private void Restore() {
        _httpClient.DefaultRequestHeaders.Clear();
    }

    public void Authenticate(string Token) {
        _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(AUTH_TOKEN, $"{Token}@{_serverSign}");
    }

    public void Disposition(string Disposition) {
        _httpClient.DefaultRequestHeaders.Add(DISPOSITION_TOKEN, Disposition);
    }
}
