﻿using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IYardLogsService {
    Task<SetViewOut<YardLog>> View(SetViewOptions options);
    Task<DatabasesTransactionOut<YardLog>> Create(YardLog[] trucks);
    Task<RecordUpdateOut<YardLog>> Update(YardLog YardLog, bool updatePivot);
    Task<YardLog> Delete(int Id);

}
