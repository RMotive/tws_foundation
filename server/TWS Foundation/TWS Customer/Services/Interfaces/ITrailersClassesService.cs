﻿using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ITrailersClassesService {
    Task<SetViewOut<TrailerClass>> View(SetViewOptions<TrailerClass> Options);
}