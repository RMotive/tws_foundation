﻿using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IDriversExternalsService {
    Task<SetViewOut<DriverExternal>> View(SetViewOptions Options);
}