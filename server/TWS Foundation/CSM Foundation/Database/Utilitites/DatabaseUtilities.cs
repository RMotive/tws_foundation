using System.Text.Json;

using CSM_Database_Core;
using CSM_Database_Core.Core.Models;

using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Database.Utilitites;
public class DatabaseUtilities {
    /// <summary>
    ///     Connection file name template for Quality environment variable.
    /// </summary>
    const string Q_CONNTION_TMPLATE = "Q_{0}.Connection";

    /// <summary>
    ///     Creates a new <typeparamref name="TDatabase"/> instance for quality/testing purposes, getting the connection options file from 
    ///     the run settings environment variables required.
    /// </summary>
    /// <typeparam name="TDatabase">
    ///     Database context handler type.
    /// </typeparam>
    /// <param name="sign">
    ///     Specific database connection sign for identification.
    /// </param>
    /// <param name="options">
    ///     Specific EF native configuration options for the instance created.
    /// </param>
    /// <returns>
    ///     An instance of <typeparamref name="TDatabase"/>.
    /// </returns>
    /// <exception cref="Exception">
    ///     <list type="bullet">
    ///         <item> Thrown when envrionment variable couldn't be found </item>
    ///         <item> Thrown when the file specified doesn't match the Connection Options format </item>
    ///         <item> Thrown when the Activator couldn't create correctly the instance of the database context </item>
    ///     </list>
    /// </exception>
    public static TDatabase Q_Construct<TDatabase>(string sign, DbContextOptions? options = null)
        where TDatabase : DatabaseBase<TDatabase> {

        string connectionVariable = string.Format(Q_CONNTION_TMPLATE, sign);

        string connectionPath = Environment.GetEnvironmentVariable(connectionVariable)
            ?? throw new Exception($"Unable to run tests for {typeof(TDatabase).FullName}, due to couldn't be found Connection file path (Make sure the environment variable [{connectionVariable}] is set or configured at the .runsettings tests context)");

        using FileStream fileReader = new(connectionPath, FileMode.Open, FileAccess.Read);

        ConnectionOptions connection = JsonSerializer.Deserialize<ConnectionOptions>(fileReader)
            ?? throw new Exception($"File ({connectionPath}) doesn't contain the correct format for (ConnectionOptions)");



        TDatabase? Database;
        if (options == null) {
            Database = (TDatabase?)Activator.CreateInstance(typeof(TDatabase), connection);
        } else {
            Database = (TDatabase?)Activator.CreateInstance(typeof(TDatabase), connection, options);
        }
        return Database ?? throw new Exception($"Unable to create ({typeof(TDatabase).FullName}) instance with the ConnectionOptions[{connectionPath}]"); ;
    }
}
