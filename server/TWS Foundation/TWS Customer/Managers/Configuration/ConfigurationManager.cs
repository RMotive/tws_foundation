using System.ComponentModel.DataAnnotations;
using System.Reflection;
using System.Text.Json;

using TWS_Customer.Managers.Configuration.Exceptions;

namespace TWS_Customer.Managers.Configuration;

/// <summary>
/// 
/// </summary>
public sealed class ConfigurationManager {
    /// <summary>
    /// 
    /// </summary>
    private static ConfigurationManager? Instance;
    /// <summary>
    /// 
    /// </summary>
    public static ConfigurationManager Manager => Instance ??= new();

    private readonly string WorkingDirectory;
    private readonly string ConfigurationsDirectory;



    /// <summary>
    /// 
    /// </summary>
    private ConfigurationManager() {
        WorkingDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location)!;
        ConfigurationsDirectory = GetConfigurationsDirectory();
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Sign"></param>
    /// <returns></returns>
    public SolutionConfiguration GetSolution(string Sign) {
        List<SolutionConfiguration> solutionConfigs = GetConfiguration<List<SolutionConfiguration>>("Solutions");

        foreach (SolutionConfiguration solutionConfig in solutionConfigs) {
            if (solutionConfig.Sign != Sign) {
                continue;
            }

            return solutionConfig;
        }

        throw new XConfigurationManager(XConfigurationManagerSituation.UnfoundSolutionConfiguration);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="Configuration"></param>
    /// <returns></returns>
    /// <exception cref="Exception"></exception>
    /// <exception cref="XConfigurationManager"></exception>
    private T GetConfiguration<T>(string Configuration) {
        string configReference = Configuration.ToLower() + "_configuration.json";

        string[] configFiles = Directory.GetFiles(ConfigurationsDirectory);
        foreach (string configFile in configFiles) {
            if (!configFile.Contains(configReference)) {
                continue;
            }

            string fileReader = File.ReadAllText(configFile);
            T configObject = JsonSerializer.Deserialize<T>(fileReader)
                ?? throw new Exception("Wrong object template to deserealize");

            return configObject;
        }

        throw new XConfigurationManager(XConfigurationManagerSituation.UnfoundConfiguration);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    /// <exception cref="XConfigurationManager"></exception>
    private string GetConfigurationsDirectory() {
        string[] appDirectories = Directory.GetDirectories(WorkingDirectory);

        foreach (string appDirectory in appDirectories) {
            if (appDirectory.Contains("Configurations")) {
                return appDirectory.Split("Configurations")[0] + "Configurations";
            }
        }

        throw new XConfigurationManager(XConfigurationManagerSituation.UnfoundDirectory);
    }
}

/// <summary>
///     
/// </summary>
public record SolutionConfiguration {
    /// <summary>
    /// 
    /// </summary>
    [MaxLength(5)]
    public required string Sign { get; init; }
    /// <summary>
    /// 
    /// </summary>
    public required bool Enabled { get; init; }
    /// <summary>
    /// 
    /// </summary>
    public required string Login { get; init; }
}
