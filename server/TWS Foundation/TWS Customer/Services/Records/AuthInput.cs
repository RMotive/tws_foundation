using System.Text.Json.Serialization;

using Microsoft.AspNetCore.Http;

namespace TWS_Customer.Services.Records;

/// <summary>
///     {model} implementation to store required data to authenticate an user into the server session manager.
/// </summary>
public record AuthInput {

    /// <summary>
    ///     Solution authentication request origin.
    /// </summary>
    public required string Sign { get; set; }

    /// <summary>
    ///     User identity.
    /// </summary>
    public required string Identity { get; init; }
    
    /// <summary>
    ///     User secret password.
    /// </summary>
    public required byte[] Password { get; init; }

    /// <summary>
    ///     {Server Side} request context access.
    /// </summary>
    [JsonIgnore]
    public IHttpContextAccessor? RequestContextAccessor { get; set;}
}
