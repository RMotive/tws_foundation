using CSM_Foundation.Database.Interfaces;

using TWS_Customer.Services.Common.DataManagement.Options;

namespace TWS_Customer.Services.Common.DataManagement;

/// <summary>
/// 
/// </summary>
public interface IDataManagementService {

    /// <summary>
    ///     
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    string ExportView(ExportViewOptions<ISet> Options);
}
