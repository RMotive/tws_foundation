﻿using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ITrucksExternalsService {
    Task<SetViewOut<TruckExternal>> View(SetViewOptions<TruckExternal> Options);
    Task<SetBatchOut<TruckExternal>> Create(TruckExternal[] trucks);
    Task<RecordUpdateOut<TruckExternal>> Update(TruckExternal Truck);
}
