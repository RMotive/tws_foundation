﻿using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Customer.Services.Interfaces;

using TWS_Security.Depots;
using TWS_Security.Sets;

namespace TWS_Customer.Services.Administration;
/// <summary>
/// 
/// </summary>
public class SolutionsService
    : ISolutionsService {
    /// <summary>
    /// 
    /// </summary>
    private readonly SolutionsDepot SolutionsDepot;
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Solutions"></param>
    public SolutionsService(SolutionsDepot Solutions) {
        SolutionsDepot = Solutions;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    public async Task<SetViewOut<Solution>> View(SetViewOptions<Solution> Options) {
        return await SolutionsDepot.View(Options);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Solutions"></param>
    /// <returns></returns>
    public async Task<SetBatchOut<Solution>> Create(Solution[] Solutions) {
        return await SolutionsDepot.Create(Solutions);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Solution"></param>
    /// <returns></returns>
    public async Task<RecordUpdateOut<Solution>> Update(Solution Solution) {
        return await SolutionsDepot.Update(Solution);
    }

    public async Task<Solution> Delete(int Id) {
        return await SolutionsDepot.Delete(Id);
    }
}
