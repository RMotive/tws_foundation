﻿

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Depots;
using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Business;
public class ManufacturersService : IManufacturersService {
    private readonly ManufacturersDepot Manufacturers;

    public ManufacturersService(ManufacturersDepot manufacturers) {
        Manufacturers = manufacturers;
    }

    public async Task<SetViewOut<Manufacturer>> View(SetViewOptions<Manufacturer> Options) {
        return await Manufacturers.View(Options);
    }

    public async Task<Manufacturer> Create(Manufacturer manufacturer) {
        return await Manufacturers.Create(manufacturer);
    }
}
