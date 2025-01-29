using CSM_Foundation.Database.Interfaces;

using TWS_Customer.Services.Common.DataManagement.Params;

namespace TWS_Customer.Services.Common.DataManagement;

/// <summary>
///     
/// </summary>
public class DataManagementService
    : IDataManagementService {

    /// <summary>
    /// 
    /// </summary>
    //private readonly DepotManager DepotManager;

    /// <summary>
    /// 
    /// </summary>
    /// <param name="DepotManager"></param>
    public DataManagementService() {
        //this.DepotManager = DepotManager;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    public string ExportView(ExportViewParams<ISet> Options) {
        throw new NotImplementedException();
    }
}
