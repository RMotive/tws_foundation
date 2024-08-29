using System.Text.Json;

using TWS_Customer.Managers.Exceptions;
using TWS_Customer.Managers.Records;

namespace TWS_Customer.Managers;

/// <summary>
/// 
/// </summary>
public sealed class ConfigurationManager {
    /// <summary>
    /// 
    /// </summary>
    static ConfigurationManager? Instance; 
    /// <summary>
    /// 
    /// </summary>
    public static ConfigurationManager Manager => Instance ??= new();


    readonly string WorkingDirectory;

    readonly string ConfigurationsDirectory;



    /// <summary>
    /// 
    /// </summary>
    ConfigurationManager() { 
        WorkingDirectory = Directory.GetCurrentDirectory();   
        ConfigurationsDirectory = GetConfigurationsDirectory();
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Sign"></param>
    /// <returns></returns>
    public SolutionConfiguration GetSolution(string Sign) {
        List<SolutionConfiguration> solutionConfigs = GetConfiguration<List<SolutionConfiguration>>("Solutions");

        foreach(SolutionConfiguration solutionConfig in solutionConfigs) {
            if(solutionConfig.Sign != Sign)
                continue;

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
        foreach(string configFile in configFiles) {
            if(!configFile.Contains(configReference))
                continue;
   

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
            if(appDirectory.Contains("Configurations")) {
                return appDirectory.Split("Configurations")[0] + "Configurations";
            }
        }

        throw new XConfigurationManager(XConfigurationManagerSituation.UnfoundDirectory);
    }
}
