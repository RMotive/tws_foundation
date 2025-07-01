using System.Diagnostics;
using System.Net;
using System.Net.Sockets;
using System.Reflection;

namespace CSM_Foundation.Server;

/// <summary>
///     {Utils} class for <see cref="ServerUtils"/>.
///     
///     
///     <para>
///         Provides static utilities methods for {Server} scope purposes.
///     </para>
/// </summary>
public static class ServerUtils {

    /// <summary>
    ///     Current server runtime environment.
    /// </summary>
    static ServerEnvironments? _envinternal;

    /// <summary>
    ///     Loads the internal <see cref="_envinternal"/> reference that stores the current server runtime environment lazyly.
    /// </summary>
    /// <returns>
    ///     The current server environment runtime mode.
    /// </returns>
    static ServerEnvironments LoadEnvironment() {
        ServerEnvironments _Mode = ServerEnvironments.development;
        Assembly[] ApplicationAssemblies = AppDomain.CurrentDomain.GetAssemblies();

        bool RunningQuality = ApplicationAssemblies
            .Any(i => (i.FullName?.StartsWith("xunit.runner", StringComparison.InvariantCultureIgnoreCase)) ?? false);

        if (RunningQuality) {
            _Mode = ServerEnvironments.quality;
            return _Mode;
        }

        if (System.Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT")?.ToLower()?.Equals("development", StringComparison.InvariantCultureIgnoreCase) ?? false) {
            _Mode = ServerEnvironments.development;
        } else if (Debugger.IsAttached) {
            _Mode = ServerEnvironments.development;
        } else {
            _Mode = ServerEnvironments.production;
        }

        return _Mode;
    }

    /// <summary>
    ///     Current server runtime environment mode detected.
    /// </summary>
    static public ServerEnvironments Environment {
        get {
            return _envinternal ??= LoadEnvironment();
        }
    }

    /// <summary>
    ///     Whether the current server runtime is {<see cref="ServerEnvironments.quality"/>} mode.
    /// </summary>
    public static bool IsQuality {
        get {
            return Environment == ServerEnvironments.quality;
        }
    }

    /// <summary>
    ///     Whether the current server runtime is {<see cref="ServerEnvironments.development"/>} mode.
    /// </summary>
    public static bool IsDevelopment {
        get {
            return Environment == ServerEnvironments.development;
        }
    }

    /// <summary>
    ///     Gets the current runtime host dns direction where the server is running on.
    /// </summary>
    /// <returns>
    ///     DNS Parsed server host direction, N/A if there's no resolvable host.
    /// </returns>
    public static string GetHost() {
        string hn = Dns.GetHostName();
        IPAddress[] @as = Dns.GetHostAddresses(hn);
        string h = @as.Where(I => I.AddressFamily == AddressFamily.InterNetwork).FirstOrDefault()?.ToString() ?? "N/A";
        return h;
    }
}
