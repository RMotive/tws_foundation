using System.Text;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Customer.Quality;
using CSM_Foundation.Database.Utilitites;

using CSM_Security.Entities;

namespace TWS_Customer.Quality;
public abstract class BQ_ServicesCustomer<TService>
    : BQ_Service<TService> {

    /// <summary>
    /// 
    /// </summary>
    protected string Entropy => RandomUtils.String(16);

    public BQ_ServicesCustomer()
        : base(
                [
                    SecurityDatabaseFactory,
                    BusinessDatabaseFactory,
                ]
            ) {
    }

    #region Database Factories

    protected static CSM_Security.Database SecurityDatabaseFactory() {
        return DatabaseUtilities.Q_Construct<CSM_Security.Database>(CSM_Security.Database.SIGN);
    }

    protected static TWS_Business.Database BusinessDatabaseFactory() {
        return DatabaseUtilities.Q_Construct<TWS_Business.Database>(TWS_Business.Database.SIGN);
    }

    #endregion

    #region Entities Factories

    /// <summary>
    ///     
    /// </summary>
    /// <returns></returns>
    protected Contact SampleContact() {
        return Store(
                new Contact {
                    Name = $"{Entropy}_name",
                    Lastname = $"{Entropy}_lastname",
                    Phone = Entropy[..10],
                    EMail = $"{Entropy}@csm.com"
                }
            );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="contact"></param>
    /// <returns></returns>
    protected Account SampleAccount(Contact? contact = null, Permit[]? permits = null, Profile[]? profiles = null) {
        Contact contactSample = contact ?? SampleContact();
        Permit[] permitSamples = permits ?? [];
        Profile[] profilesSamples = profiles ?? [];

        return Store(
                new Account {
                    User = $"{Entropy}_usr",
                    Password = Encoding.UTF8.GetBytes($"{Entropy}_pwd"),
                    Contact = contactSample,
                    Permits = permitSamples,
                    Profiles = profilesSamples,
                }
            );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="enabled"></param>
    /// <returns></returns>
    protected CSM_Security.Entities.Action SampleAction(bool enabled = true) {
        return Store(
                new CSM_Security.Entities.Action {
                    Name = $"Action_{Entropy}",
                    Description = $"$Action_{Entropy}_Description",
                    Enabled = enabled,
                }
            );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    protected Solution SampleSolution() {
        return Store(
                new Solution {
                    Name = $"Solution_{Entropy}",
                    Sign = Entropy[..5],
                    Description = $"Solution_{Entropy}_Description",
                }
            );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="enabled"></param>
    /// <returns></returns>
    protected Feature SampleFeature(bool enabled = true) {
        return Store(
                new Feature {
                    Name = $"Feature_{Entropy}",
                    Description = $"Feature_{Entropy}_Description",
                    Enabled = enabled,
                }
            );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="feature"></param>
    /// <param name="solution"></param>
    /// <param name="action"></param>
    /// <param name="enabled"></param>
    /// <returns></returns>
    protected Permit SamplePermit(Feature? feature = null, Solution? solution = null, CSM_Security.Entities.Action? action = null, bool enabled = true) {

        CSM_Security.Entities.Action actionSample = action ?? SampleAction();
        Solution solutionSample = solution ?? SampleSolution();
        Feature featureSample = feature ?? SampleFeature();

        return Store(
                new Permit {
                    Reference = Entropy[..8],
                    Enabled = enabled,
                    Action = actionSample,
                    Feature = featureSample,
                    Solution = solutionSample,
                }
            );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="permits"></param>
    /// <returns></returns>
    protected Profile SampleProfile(Permit[]? permits = null) {
        Permit[] samplePermits = permits ?? [];

        return Store(
                new Profile {
                    Name = $"Profile_{Entropy}",
                    Description = $"Profile_{Entropy}_Description",
                    Permits = samplePermits,
                }
            );
    }

    #endregion
}
