﻿using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface ICarriersService {
    Task<SetViewOut<Carrier>> View(SetViewOptions<Carrier> Options);

    Task<Carrier> Create(Carrier manufacturer);
}
