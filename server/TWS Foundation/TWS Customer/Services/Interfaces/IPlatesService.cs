﻿using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IPlatesService {

    Task<SetViewOut<Plate>> View(SetViewOptions<Plate> options);

    Task<Plate> Create(Plate plate);
}
