
using System.Net;

using CSM_Foundation.Core.Bases;

namespace TWS_Customer.Services.Exceptions;
public class XTruckAssembly : BException<XTruckAssemblySituation> {

    public XTruckAssembly(XTruckAssemblySituation Situation)
        : base($"", HttpStatusCode.BadRequest, null) {
        this.Situation = Situation;
        Advise = Situation switch {
            XTruckAssemblySituation.RequiredManufacturer => $"None Model data found.",
            XTruckAssemblySituation.RequiredPlates => $"None Plates data found.",
            XTruckAssemblySituation.ManufacturerNotExist => $"The given Model not exist",
            XTruckAssemblySituation.SitutionNotExist => $"The given Situation ID not exist",

            _ => throw new NotImplementedException()
        };
    }
}

public enum XTruckAssemblySituation {
    RequiredManufacturer,
    RequiredPlates,
    ManufacturerNotExist,
    SitutionNotExist
}
